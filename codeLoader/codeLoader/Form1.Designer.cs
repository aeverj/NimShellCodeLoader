namespace codeLoader
{
    partial class CodeLoaderGen
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CodeLoaderGen));
            this.button_gen = new System.Windows.Forms.Button();
            this.textBox_codePath = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBox_cmdline = new System.Windows.Forms.TextBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.comboBox_Method = new System.Windows.Forms.ComboBox();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.textBox_output = new System.Windows.Forms.TextBox();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.radioButton1 = new System.Windows.Forms.RadioButton();
            this.radioButton_encrypt = new System.Windows.Forms.RadioButton();
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.icoGroup = new System.Windows.Forms.GroupBox();
            this.button_clear = new System.Windows.Forms.Button();
            this.icoBox = new System.Windows.Forms.PictureBox();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.icoGroup.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.icoBox)).BeginInit();
            this.SuspendLayout();
            // 
            // button_gen
            // 
            this.button_gen.Location = new System.Drawing.Point(537, 505);
            this.button_gen.Name = "button_gen";
            this.button_gen.Size = new System.Drawing.Size(75, 27);
            this.button_gen.TabIndex = 0;
            this.button_gen.Text = "Generate";
            this.button_gen.UseVisualStyleBackColor = true;
            this.button_gen.Click += new System.EventHandler(this.button_gen_Click);
            // 
            // textBox_codePath
            // 
            this.textBox_codePath.AllowDrop = true;
            this.textBox_codePath.Font = new System.Drawing.Font("宋体", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.textBox_codePath.Location = new System.Drawing.Point(137, 10);
            this.textBox_codePath.Name = "textBox_codePath";
            this.textBox_codePath.ReadOnly = true;
            this.textBox_codePath.Size = new System.Drawing.Size(472, 23);
            this.textBox_codePath.TabIndex = 1;
            this.textBox_codePath.TextChanged += new System.EventHandler(this.textBox_codePath_TextChanged);
            this.textBox_codePath.DragEnter += new System.Windows.Forms.DragEventHandler(this.textBox_codePath_DragEnter);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("宋体", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label1.Location = new System.Drawing.Point(12, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(119, 14);
            this.label1.TabIndex = 2;
            this.label1.Text = "ShellCode Path :";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBox_cmdline);
            this.groupBox2.Location = new System.Drawing.Point(14, 193);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(10, 5, 10, 10);
            this.groupBox2.Size = new System.Drawing.Size(601, 101);
            this.groupBox2.TabIndex = 5;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Args";
            // 
            // textBox_cmdline
            // 
            this.textBox_cmdline.Dock = System.Windows.Forms.DockStyle.Fill;
            this.textBox_cmdline.Location = new System.Drawing.Point(10, 21);
            this.textBox_cmdline.Margin = new System.Windows.Forms.Padding(20);
            this.textBox_cmdline.Multiline = true;
            this.textBox_cmdline.Name = "textBox_cmdline";
            this.textBox_cmdline.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox_cmdline.Size = new System.Drawing.Size(581, 70);
            this.textBox_cmdline.TabIndex = 0;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.comboBox_Method);
            this.groupBox3.Location = new System.Drawing.Point(168, 111);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Padding = new System.Windows.Forms.Padding(20, 15, 20, 20);
            this.groupBox3.Size = new System.Drawing.Size(447, 73);
            this.groupBox3.TabIndex = 6;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Load Technology";
            // 
            // comboBox_Method
            // 
            this.comboBox_Method.Dock = System.Windows.Forms.DockStyle.Fill;
            this.comboBox_Method.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox_Method.FormattingEnabled = true;
            this.comboBox_Method.Location = new System.Drawing.Point(20, 31);
            this.comboBox_Method.Name = "comboBox_Method";
            this.comboBox_Method.Size = new System.Drawing.Size(407, 22);
            this.comboBox_Method.TabIndex = 0;
            this.comboBox_Method.SelectedIndexChanged += new System.EventHandler(this.comboBox_Method_SelectedIndexChanged);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.textBox_output);
            this.groupBox4.Location = new System.Drawing.Point(14, 319);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Padding = new System.Windows.Forms.Padding(10, 5, 10, 10);
            this.groupBox4.Size = new System.Drawing.Size(601, 179);
            this.groupBox4.TabIndex = 7;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Output";
            // 
            // textBox_output
            // 
            this.textBox_output.BackColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.textBox_output.Dock = System.Windows.Forms.DockStyle.Fill;
            this.textBox_output.ForeColor = System.Drawing.Color.Chartreuse;
            this.textBox_output.Location = new System.Drawing.Point(10, 21);
            this.textBox_output.Multiline = true;
            this.textBox_output.Name = "textBox_output";
            this.textBox_output.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox_output.Size = new System.Drawing.Size(581, 148);
            this.textBox_output.TabIndex = 0;
            this.textBox_output.TextChanged += new System.EventHandler(this.textBox_output_TextChanged);
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.radioButton1);
            this.groupBox5.Controls.Add(this.radioButton_encrypt);
            this.groupBox5.Location = new System.Drawing.Point(168, 43);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Padding = new System.Windows.Forms.Padding(8, 5, 8, 5);
            this.groupBox5.Size = new System.Drawing.Size(152, 47);
            this.groupBox5.TabIndex = 5;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Encryption";
            // 
            // radioButton1
            // 
            this.radioButton1.AutoSize = true;
            this.radioButton1.Dock = System.Windows.Forms.DockStyle.Right;
            this.radioButton1.Location = new System.Drawing.Point(91, 21);
            this.radioButton1.Name = "radioButton1";
            this.radioButton1.Size = new System.Drawing.Size(53, 21);
            this.radioButton1.TabIndex = 3;
            this.radioButton1.Text = "TDEA";
            this.radioButton1.UseVisualStyleBackColor = true;
            // 
            // radioButton_encrypt
            // 
            this.radioButton_encrypt.AutoSize = true;
            this.radioButton_encrypt.Checked = true;
            this.radioButton_encrypt.Dock = System.Windows.Forms.DockStyle.Left;
            this.radioButton_encrypt.Location = new System.Drawing.Point(8, 21);
            this.radioButton_encrypt.Name = "radioButton_encrypt";
            this.radioButton_encrypt.Size = new System.Drawing.Size(67, 21);
            this.radioButton_encrypt.TabIndex = 2;
            this.radioButton_encrypt.TabStop = true;
            this.radioButton_encrypt.Text = "Caesar";
            this.radioButton_encrypt.UseVisualStyleBackColor = true;
            this.radioButton_encrypt.CheckedChanged += new System.EventHandler(this.radioButton_encrypt_CheckedChanged);
            // 
            // linkLabel1
            // 
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Location = new System.Drawing.Point(18, 512);
            this.linkLabel1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.Size = new System.Drawing.Size(210, 14);
            this.linkLabel1.TabIndex = 8;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "https://www.github.com/aeverj";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel1_LinkClicked);
            // 
            // icoGroup
            // 
            this.icoGroup.Controls.Add(this.button_clear);
            this.icoGroup.Controls.Add(this.icoBox);
            this.icoGroup.Location = new System.Drawing.Point(20, 43);
            this.icoGroup.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.icoGroup.Name = "icoGroup";
            this.icoGroup.Padding = new System.Windows.Forms.Padding(23, 2, 23, 10);
            this.icoGroup.Size = new System.Drawing.Size(127, 141);
            this.icoGroup.TabIndex = 9;
            this.icoGroup.TabStop = false;
            this.icoGroup.Text = "ICO";
            // 
            // button_clear
            // 
            this.button_clear.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.button_clear.Location = new System.Drawing.Point(23, 108);
            this.button_clear.Margin = new System.Windows.Forms.Padding(2);
            this.button_clear.Name = "button_clear";
            this.button_clear.Size = new System.Drawing.Size(81, 23);
            this.button_clear.TabIndex = 10;
            this.button_clear.Text = "Clear";
            this.button_clear.UseVisualStyleBackColor = true;
            this.button_clear.Click += new System.EventHandler(this.button_clear_Click);
            // 
            // icoBox
            // 
            this.icoBox.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.icoBox.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.icoBox.Dock = System.Windows.Forms.DockStyle.Top;
            this.icoBox.Location = new System.Drawing.Point(23, 18);
            this.icoBox.Margin = new System.Windows.Forms.Padding(2);
            this.icoBox.Name = "icoBox";
            this.icoBox.Size = new System.Drawing.Size(81, 81);
            this.icoBox.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.icoBox.TabIndex = 0;
            this.icoBox.TabStop = false;
            this.icoBox.DragEnter += new System.Windows.Forms.DragEventHandler(this.icoBox_DragEnter);
            // 
            // CodeLoaderGen
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
            this.ClientSize = new System.Drawing.Size(618, 540);
            this.Controls.Add(this.icoGroup);
            this.Controls.Add(this.linkLabel1);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox_codePath);
            this.Controls.Add(this.button_gen);
            this.Font = new System.Drawing.Font("宋体", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "CodeLoaderGen";
            this.Text = "CodeLoaderGen";
            this.Load += new System.EventHandler(this.CodeLoaderGen_Load);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.icoGroup.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.icoBox)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_gen;
        private System.Windows.Forms.TextBox textBox_codePath;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox textBox_cmdline;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.ComboBox comboBox_Method;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.TextBox textBox_output;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.RadioButton radioButton1;
        private System.Windows.Forms.RadioButton radioButton_encrypt;
        private System.Windows.Forms.LinkLabel linkLabel1;
        private System.Windows.Forms.GroupBox icoGroup;
        private System.Windows.Forms.Button button_clear;
        private System.Windows.Forms.PictureBox icoBox;
    }
}

