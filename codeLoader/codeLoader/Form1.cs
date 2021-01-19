using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;

namespace codeLoader
{
    public partial class CodeLoaderGen : Form
    {
        IniParse ini;
        string sourcePath;
        string encryption;
        string cmdline;
        Process process;
        public CodeLoaderGen()
        {
            InitializeComponent();
        }
        private void run_output(string command)
        {
            process = new Process();
            process.StartInfo.FileName = "cmd.exe";
            process.StartInfo.Arguments = "/c " + command;
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.RedirectStandardInput = true;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.CreateNoWindow = true;
            process.Start();
            process.StandardInput.AutoFlush = true;
            process.BeginErrorReadLine();
            process.BeginOutputReadLine();
            process.OutputDataReceived += new DataReceivedEventHandler(Process_OutputDataReceived);
            process.ErrorDataReceived += new DataReceivedEventHandler(Process_OutputDataReceived);
            button_gen.Enabled = false;
        }

        private void Process_OutputDataReceived(object sender, DataReceivedEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Data))
            {
                this.textBox_output.BeginInvoke((MethodInvoker)(() =>
                {
                    textBox_output.Text += e.Data + "\r\n";
                }));
            }
            else
            {
                if (process.HasExited)
                {
                    this.button_gen.BeginInvoke((MethodInvoker)(() =>
                    {
                        button_gen.Enabled = true;
                    }));
                }
            }
        }

        private void button_gen_Click(object sender, EventArgs e)
        {
            textBox_output.Text = textBox_cmdline.Text +"\r\n" + "---------------------------------" + "\r\n";
            run_output(textBox_cmdline.Text);
        }

        private void CodeLoaderGen_DragEnter(object sender, DragEventArgs e)
        {
            string path = ((System.Array)e.Data.GetData(DataFormats.FileDrop)).GetValue(0).ToString();
            textBox_codePath.Text = path;
        }

        private void CodeLoaderGen_Load(object sender, EventArgs e)
        {
            ini = new IniParse(@".\Compiler.ini");
            try
            {
                List<string> loadList = ini.GetKeyList("compile");
                comboBox_Method.DataSource = loadList;
            }
            catch (Exception)
            {
                MessageBox.Show("配置文件错误！","错误！");
                Environment.Exit(0);
            }
            cmdlineChangeCallback();
        }

        private void comboBox_Method_SelectedIndexChanged(object sender, EventArgs e)
        {
            cmdlineChangeCallback();
        }
        private void cmdlineChangeCallback()
        {
            sourcePath = textBox_codePath.Text;
            encryption = radioButton_encrypt.Checked ? "Caesar" : "TDEA";
            string tmpArg = ini.IniReadValue("compile", comboBox_Method.Text);
            cmdline = tmpArg.Replace("<encrypt>", encryption);
            if (!string.IsNullOrEmpty(sourcePath))
            {
                cmdline = cmdline.Replace("<source>", sourcePath);
                button_gen.Enabled = true;
            }
            else
            {
                button_gen.Enabled = false;
            }
            textBox_cmdline.Text = cmdline;
        }

        private void textBox_codePath_TextChanged(object sender, EventArgs e)
        {
            cmdlineChangeCallback();
        }
        private void radioButton_encrypt_CheckedChanged(object sender, EventArgs e)
        {
            cmdlineChangeCallback();
        }

        private void textBox_output_TextChanged(object sender, EventArgs e)
        {
            textBox_output.SelectionStart = textBox_output.Text.Length;
            textBox_output.ScrollToCaret();
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start(linkLabel1.Text);
        }
    }
}
