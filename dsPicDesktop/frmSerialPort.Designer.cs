namespace dsPicDesktop
{
    partial class frmSerialPort
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblSerialPortName = new System.Windows.Forms.Label();
            this.grpSerialPort = new System.Windows.Forms.GroupBox();
            this.cboDataBits = new System.Windows.Forms.ComboBox();
            this.cboParities = new System.Windows.Forms.ComboBox();
            this.btnDisconnect = new System.Windows.Forms.Button();
            this.btnConnect = new System.Windows.Forms.Button();
            this.cboStopBits = new System.Windows.Forms.ComboBox();
            this.lblDataBits = new System.Windows.Forms.Label();
            this.cboBaudRate = new System.Windows.Forms.ComboBox();
            this.lblParities = new System.Windows.Forms.Label();
            this.picPortActive = new System.Windows.Forms.PictureBox();
            this.lblStopBits = new System.Windows.Forms.Label();
            this.cboSerialPorts = new System.Windows.Forms.ComboBox();
            this.lblBaudRate = new System.Windows.Forms.Label();
            this.webPortDesc = new System.Windows.Forms.WebBrowser();
            this.grpTetTransfer = new System.Windows.Forms.GroupBox();
            this.cboPICDataFormat = new System.Windows.Forms.ComboBox();
            this.btnPICClear = new System.Windows.Forms.Button();
            this.btnPCClear = new System.Windows.Forms.Button();
            this.btnRefreshPICData = new System.Windows.Forms.Button();
            this.btnPCSend = new System.Windows.Forms.Button();
            this.lblPICDataFormat = new System.Windows.Forms.Label();
            this.lblPIC = new System.Windows.Forms.Label();
            this.lblPC = new System.Windows.Forms.Label();
            this.txtPIC = new System.Windows.Forms.TextBox();
            this.txtPC = new System.Windows.Forms.TextBox();
            this.chkTruncate = new System.Windows.Forms.CheckBox();
            this.grpSerialPort.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picPortActive)).BeginInit();
            this.grpTetTransfer.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblSerialPortName
            // 
            this.lblSerialPortName.AutoSize = true;
            this.lblSerialPortName.Location = new System.Drawing.Point(17, 22);
            this.lblSerialPortName.Name = "lblSerialPortName";
            this.lblSerialPortName.Size = new System.Drawing.Size(29, 13);
            this.lblSerialPortName.TabIndex = 0;
            this.lblSerialPortName.Text = "Port:";
            // 
            // grpSerialPort
            // 
            this.grpSerialPort.Controls.Add(this.cboDataBits);
            this.grpSerialPort.Controls.Add(this.cboParities);
            this.grpSerialPort.Controls.Add(this.btnDisconnect);
            this.grpSerialPort.Controls.Add(this.btnConnect);
            this.grpSerialPort.Controls.Add(this.cboStopBits);
            this.grpSerialPort.Controls.Add(this.lblDataBits);
            this.grpSerialPort.Controls.Add(this.cboBaudRate);
            this.grpSerialPort.Controls.Add(this.lblParities);
            this.grpSerialPort.Controls.Add(this.picPortActive);
            this.grpSerialPort.Controls.Add(this.lblStopBits);
            this.grpSerialPort.Controls.Add(this.cboSerialPorts);
            this.grpSerialPort.Controls.Add(this.lblBaudRate);
            this.grpSerialPort.Controls.Add(this.lblSerialPortName);
            this.grpSerialPort.Location = new System.Drawing.Point(12, 12);
            this.grpSerialPort.Name = "grpSerialPort";
            this.grpSerialPort.Size = new System.Drawing.Size(642, 191);
            this.grpSerialPort.TabIndex = 1;
            this.grpSerialPort.TabStop = false;
            this.grpSerialPort.Text = "Serial Port:";
            // 
            // cboDataBits
            // 
            this.cboDataBits.FormattingEnabled = true;
            this.cboDataBits.Location = new System.Drawing.Point(90, 125);
            this.cboDataBits.Name = "cboDataBits";
            this.cboDataBits.Size = new System.Drawing.Size(121, 21);
            this.cboDataBits.TabIndex = 3;
            // 
            // cboParities
            // 
            this.cboParities.FormattingEnabled = true;
            this.cboParities.Location = new System.Drawing.Point(90, 98);
            this.cboParities.Name = "cboParities";
            this.cboParities.Size = new System.Drawing.Size(121, 21);
            this.cboParities.TabIndex = 3;
            // 
            // btnDisconnect
            // 
            this.btnDisconnect.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnDisconnect.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDisconnect.Location = new System.Drawing.Point(554, 162);
            this.btnDisconnect.Name = "btnDisconnect";
            this.btnDisconnect.Size = new System.Drawing.Size(77, 23);
            this.btnDisconnect.TabIndex = 2;
            this.btnDisconnect.Text = "Disconnect";
            this.btnDisconnect.UseVisualStyleBackColor = false;
            this.btnDisconnect.Click += new System.EventHandler(this.btnDisconnect_Click);
            // 
            // btnConnect
            // 
            this.btnConnect.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnConnect.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnConnect.Location = new System.Drawing.Point(483, 162);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(65, 23);
            this.btnConnect.TabIndex = 2;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = false;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // cboStopBits
            // 
            this.cboStopBits.FormattingEnabled = true;
            this.cboStopBits.Location = new System.Drawing.Point(90, 71);
            this.cboStopBits.Name = "cboStopBits";
            this.cboStopBits.Size = new System.Drawing.Size(121, 21);
            this.cboStopBits.TabIndex = 3;
            // 
            // lblDataBits
            // 
            this.lblDataBits.AutoSize = true;
            this.lblDataBits.Location = new System.Drawing.Point(17, 128);
            this.lblDataBits.Name = "lblDataBits";
            this.lblDataBits.Size = new System.Drawing.Size(53, 13);
            this.lblDataBits.TabIndex = 0;
            this.lblDataBits.Text = "Data Bits:";
            // 
            // cboBaudRate
            // 
            this.cboBaudRate.FormattingEnabled = true;
            this.cboBaudRate.Location = new System.Drawing.Point(90, 44);
            this.cboBaudRate.Name = "cboBaudRate";
            this.cboBaudRate.Size = new System.Drawing.Size(121, 21);
            this.cboBaudRate.TabIndex = 3;
            // 
            // lblParities
            // 
            this.lblParities.AutoSize = true;
            this.lblParities.Location = new System.Drawing.Point(17, 101);
            this.lblParities.Name = "lblParities";
            this.lblParities.Size = new System.Drawing.Size(36, 13);
            this.lblParities.TabIndex = 0;
            this.lblParities.Text = "Parity:";
            // 
            // picPortActive
            // 
            this.picPortActive.Image = global::dsPicDesktop.Properties.Resources.tick;
            this.picPortActive.Location = new System.Drawing.Point(217, 18);
            this.picPortActive.Name = "picPortActive";
            this.picPortActive.Size = new System.Drawing.Size(24, 24);
            this.picPortActive.TabIndex = 2;
            this.picPortActive.TabStop = false;
            // 
            // lblStopBits
            // 
            this.lblStopBits.AutoSize = true;
            this.lblStopBits.Location = new System.Drawing.Point(17, 74);
            this.lblStopBits.Name = "lblStopBits";
            this.lblStopBits.Size = new System.Drawing.Size(52, 13);
            this.lblStopBits.TabIndex = 0;
            this.lblStopBits.Text = "Stop Bits:";
            // 
            // cboSerialPorts
            // 
            this.cboSerialPorts.FormattingEnabled = true;
            this.cboSerialPorts.Location = new System.Drawing.Point(90, 19);
            this.cboSerialPorts.Name = "cboSerialPorts";
            this.cboSerialPorts.Size = new System.Drawing.Size(121, 21);
            this.cboSerialPorts.TabIndex = 1;
            this.cboSerialPorts.SelectedIndexChanged += new System.EventHandler(this.cboSerialPorts_SelectedIndexChanged);
            // 
            // lblBaudRate
            // 
            this.lblBaudRate.AutoSize = true;
            this.lblBaudRate.Location = new System.Drawing.Point(17, 47);
            this.lblBaudRate.Name = "lblBaudRate";
            this.lblBaudRate.Size = new System.Drawing.Size(61, 13);
            this.lblBaudRate.TabIndex = 0;
            this.lblBaudRate.Text = "Baud Rate:";
            // 
            // webPortDesc
            // 
            this.webPortDesc.Location = new System.Drawing.Point(259, 30);
            this.webPortDesc.MinimumSize = new System.Drawing.Size(20, 20);
            this.webPortDesc.Name = "webPortDesc";
            this.webPortDesc.Size = new System.Drawing.Size(384, 133);
            this.webPortDesc.TabIndex = 4;
            // 
            // grpTetTransfer
            // 
            this.grpTetTransfer.Controls.Add(this.chkTruncate);
            this.grpTetTransfer.Controls.Add(this.cboPICDataFormat);
            this.grpTetTransfer.Controls.Add(this.btnPICClear);
            this.grpTetTransfer.Controls.Add(this.btnPCClear);
            this.grpTetTransfer.Controls.Add(this.btnRefreshPICData);
            this.grpTetTransfer.Controls.Add(this.btnPCSend);
            this.grpTetTransfer.Controls.Add(this.lblPICDataFormat);
            this.grpTetTransfer.Controls.Add(this.lblPIC);
            this.grpTetTransfer.Controls.Add(this.lblPC);
            this.grpTetTransfer.Controls.Add(this.txtPIC);
            this.grpTetTransfer.Controls.Add(this.txtPC);
            this.grpTetTransfer.Location = new System.Drawing.Point(12, 209);
            this.grpTetTransfer.Name = "grpTetTransfer";
            this.grpTetTransfer.Size = new System.Drawing.Size(642, 313);
            this.grpTetTransfer.TabIndex = 5;
            this.grpTetTransfer.TabStop = false;
            this.grpTetTransfer.Text = "Communication:";
            // 
            // cboPICDataFormat
            // 
            this.cboPICDataFormat.FormattingEnabled = true;
            this.cboPICDataFormat.Location = new System.Drawing.Point(181, 286);
            this.cboPICDataFormat.Name = "cboPICDataFormat";
            this.cboPICDataFormat.Size = new System.Drawing.Size(121, 21);
            this.cboPICDataFormat.TabIndex = 3;
            // 
            // btnPICClear
            // 
            this.btnPICClear.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnPICClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPICClear.Location = new System.Drawing.Point(577, 284);
            this.btnPICClear.Name = "btnPICClear";
            this.btnPICClear.Size = new System.Drawing.Size(54, 23);
            this.btnPICClear.TabIndex = 2;
            this.btnPICClear.Text = "Clear";
            this.btnPICClear.UseVisualStyleBackColor = false;
            this.btnPICClear.Click += new System.EventHandler(this.btnPICClear_Click);
            // 
            // btnPCClear
            // 
            this.btnPCClear.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnPCClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPCClear.Location = new System.Drawing.Point(577, 19);
            this.btnPCClear.Name = "btnPCClear";
            this.btnPCClear.Size = new System.Drawing.Size(54, 23);
            this.btnPCClear.TabIndex = 2;
            this.btnPCClear.Text = "Clear";
            this.btnPCClear.UseVisualStyleBackColor = false;
            this.btnPCClear.Click += new System.EventHandler(this.btnPCClear_Click);
            // 
            // btnRefreshPICData
            // 
            this.btnRefreshPICData.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnRefreshPICData.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnRefreshPICData.Location = new System.Drawing.Point(308, 284);
            this.btnRefreshPICData.Name = "btnRefreshPICData";
            this.btnRefreshPICData.Size = new System.Drawing.Size(54, 23);
            this.btnRefreshPICData.TabIndex = 2;
            this.btnRefreshPICData.Text = "Refresh";
            this.btnRefreshPICData.UseVisualStyleBackColor = false;
            this.btnRefreshPICData.Click += new System.EventHandler(this.btnRefreshPICData_Click);
            // 
            // btnPCSend
            // 
            this.btnPCSend.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnPCSend.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPCSend.Location = new System.Drawing.Point(517, 19);
            this.btnPCSend.Name = "btnPCSend";
            this.btnPCSend.Size = new System.Drawing.Size(54, 23);
            this.btnPCSend.TabIndex = 2;
            this.btnPCSend.Text = "Send";
            this.btnPCSend.UseVisualStyleBackColor = false;
            this.btnPCSend.Click += new System.EventHandler(this.btnPCSend_Click);
            // 
            // lblPICDataFormat
            // 
            this.lblPICDataFormat.AutoSize = true;
            this.lblPICDataFormat.Location = new System.Drawing.Point(87, 289);
            this.lblPICDataFormat.Name = "lblPICDataFormat";
            this.lblPICDataFormat.Size = new System.Drawing.Size(88, 13);
            this.lblPICDataFormat.TabIndex = 0;
            this.lblPICDataFormat.Text = "PIC Data Format:";
            // 
            // lblPIC
            // 
            this.lblPIC.AutoSize = true;
            this.lblPIC.Location = new System.Drawing.Point(17, 51);
            this.lblPIC.Name = "lblPIC";
            this.lblPIC.Size = new System.Drawing.Size(27, 13);
            this.lblPIC.TabIndex = 1;
            this.lblPIC.Text = "PIC:";
            // 
            // lblPC
            // 
            this.lblPC.AutoSize = true;
            this.lblPC.Location = new System.Drawing.Point(17, 25);
            this.lblPC.Name = "lblPC";
            this.lblPC.Size = new System.Drawing.Size(24, 13);
            this.lblPC.TabIndex = 1;
            this.lblPC.Text = "PC:";
            // 
            // txtPIC
            // 
            this.txtPIC.Location = new System.Drawing.Point(90, 48);
            this.txtPIC.Multiline = true;
            this.txtPIC.Name = "txtPIC";
            this.txtPIC.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtPIC.Size = new System.Drawing.Size(541, 230);
            this.txtPIC.TabIndex = 0;
            // 
            // txtPC
            // 
            this.txtPC.Location = new System.Drawing.Point(90, 22);
            this.txtPC.Name = "txtPC";
            this.txtPC.Size = new System.Drawing.Size(421, 20);
            this.txtPC.TabIndex = 0;
            // 
            // chkTruncate
            // 
            this.chkTruncate.AutoSize = true;
            this.chkTruncate.Location = new System.Drawing.Point(378, 288);
            this.chkTruncate.Name = "chkTruncate";
            this.chkTruncate.Size = new System.Drawing.Size(113, 17);
            this.chkTruncate.TabIndex = 4;
            this.chkTruncate.Text = "Truncate PIC data";
            this.chkTruncate.UseVisualStyleBackColor = true;
            // 
            // frmSerialPort
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(665, 534);
            this.Controls.Add(this.grpTetTransfer);
            this.Controls.Add(this.webPortDesc);
            this.Controls.Add(this.grpSerialPort);
            this.Name = "frmSerialPort";
            this.Text = "frmSerialPort";
            this.Load += new System.EventHandler(this.frmSerialPort_Load);
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.frmSerialPort_FormClosed);
            this.grpSerialPort.ResumeLayout(false);
            this.grpSerialPort.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.picPortActive)).EndInit();
            this.grpTetTransfer.ResumeLayout(false);
            this.grpTetTransfer.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblSerialPortName;
        private System.Windows.Forms.GroupBox grpSerialPort;
        private System.Windows.Forms.ComboBox cboSerialPorts;
        private System.Windows.Forms.PictureBox picPortActive;
        private System.Windows.Forms.Label lblBaudRate;
        private System.Windows.Forms.ComboBox cboBaudRate;
        private System.Windows.Forms.ComboBox cboStopBits;
        private System.Windows.Forms.Label lblStopBits;
        private System.Windows.Forms.ComboBox cboParities;
        private System.Windows.Forms.Label lblParities;
        private System.Windows.Forms.ComboBox cboDataBits;
        private System.Windows.Forms.Label lblDataBits;
        private System.Windows.Forms.WebBrowser webPortDesc;
        private System.Windows.Forms.GroupBox grpTetTransfer;
        private System.Windows.Forms.Label lblPIC;
        private System.Windows.Forms.Label lblPC;
        private System.Windows.Forms.TextBox txtPIC;
        private System.Windows.Forms.TextBox txtPC;
        private System.Windows.Forms.Button btnPCClear;
        private System.Windows.Forms.Button btnPCSend;
        private System.Windows.Forms.Button btnPICClear;
        private System.Windows.Forms.Button btnDisconnect;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.ComboBox cboPICDataFormat;
        private System.Windows.Forms.Label lblPICDataFormat;
        private System.Windows.Forms.Button btnRefreshPICData;
        private System.Windows.Forms.CheckBox chkTruncate;
    }
}