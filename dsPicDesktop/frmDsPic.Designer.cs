namespace dsPicDesktop
{
    partial class frmDsPic
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
            this.menuStripDsPic = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dsPicToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.serialToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.distanceMeterToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripDsPic = new System.Windows.Forms.ToolStrip();
            this.toolStripButtonSerialPort = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.toolStripButtonDistanceMeter = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.statusStripDsPic = new System.Windows.Forms.StatusStrip();
            this.distancePlotToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripButtonDistancePlot = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.menuStripDsPic.SuspendLayout();
            this.toolStripDsPic.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStripDsPic
            // 
            this.menuStripDsPic.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.dsPicToolStripMenuItem});
            this.menuStripDsPic.Location = new System.Drawing.Point(0, 0);
            this.menuStripDsPic.Name = "menuStripDsPic";
            this.menuStripDsPic.RenderMode = System.Windows.Forms.ToolStripRenderMode.System;
            this.menuStripDsPic.Size = new System.Drawing.Size(734, 24);
            this.menuStripDsPic.TabIndex = 1;
            this.menuStripDsPic.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.file;
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(51, 20);
            this.fileToolStripMenuItem.Text = "&File";
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.exit;
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(92, 22);
            this.exitToolStripMenuItem.Text = "&Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // dsPicToolStripMenuItem
            // 
            this.dsPicToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.serialToolStripMenuItem,
            this.distanceMeterToolStripMenuItem,
            this.distancePlotToolStripMenuItem});
            this.dsPicToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.dsPic;
            this.dsPicToolStripMenuItem.Name = "dsPicToolStripMenuItem";
            this.dsPicToolStripMenuItem.Size = new System.Drawing.Size(60, 20);
            this.dsPicToolStripMenuItem.Text = "&DsPic";
            // 
            // serialToolStripMenuItem
            // 
            this.serialToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.serialport;
            this.serialToolStripMenuItem.Name = "serialToolStripMenuItem";
            this.serialToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.serialToolStripMenuItem.Text = "&Serial";
            this.serialToolStripMenuItem.Click += new System.EventHandler(this.serialToolStripMenuItem_Click);
            // 
            // distanceMeterToolStripMenuItem
            // 
            this.distanceMeterToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.distancemeter;
            this.distanceMeterToolStripMenuItem.Name = "distanceMeterToolStripMenuItem";
            this.distanceMeterToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.distanceMeterToolStripMenuItem.Text = "Distance Meter";
            this.distanceMeterToolStripMenuItem.Click += new System.EventHandler(this.distanceMeterToolStripMenuItem_Click);
            // 
            // toolStripDsPic
            // 
            this.toolStripDsPic.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripButtonSerialPort,
            this.toolStripSeparator1,
            this.toolStripButtonDistanceMeter,
            this.toolStripSeparator2,
            this.toolStripButtonDistancePlot,
            this.toolStripSeparator3});
            this.toolStripDsPic.Location = new System.Drawing.Point(0, 24);
            this.toolStripDsPic.Name = "toolStripDsPic";
            this.toolStripDsPic.RenderMode = System.Windows.Forms.ToolStripRenderMode.System;
            this.toolStripDsPic.Size = new System.Drawing.Size(734, 55);
            this.toolStripDsPic.TabIndex = 2;
            this.toolStripDsPic.Text = "toolStrip1";
            // 
            // toolStripButtonSerialPort
            // 
            this.toolStripButtonSerialPort.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButtonSerialPort.Image = global::dsPicDesktop.Properties.Resources.serialport;
            this.toolStripButtonSerialPort.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.toolStripButtonSerialPort.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButtonSerialPort.Name = "toolStripButtonSerialPort";
            this.toolStripButtonSerialPort.Size = new System.Drawing.Size(52, 52);
            this.toolStripButtonSerialPort.Text = "toolStripButton1";
            this.toolStripButtonSerialPort.Click += new System.EventHandler(this.toolStripButtonSerialPort_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 55);
            // 
            // toolStripButtonDistanceMeter
            // 
            this.toolStripButtonDistanceMeter.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButtonDistanceMeter.Image = global::dsPicDesktop.Properties.Resources.distancemeter;
            this.toolStripButtonDistanceMeter.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.toolStripButtonDistanceMeter.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButtonDistanceMeter.Name = "toolStripButtonDistanceMeter";
            this.toolStripButtonDistanceMeter.Size = new System.Drawing.Size(52, 52);
            this.toolStripButtonDistanceMeter.Text = "toolStripButton1";
            this.toolStripButtonDistanceMeter.Click += new System.EventHandler(this.toolStripButtonDistanceMeter_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 55);
            // 
            // statusStripDsPic
            // 
            this.statusStripDsPic.Location = new System.Drawing.Point(0, 462);
            this.statusStripDsPic.Name = "statusStripDsPic";
            this.statusStripDsPic.Size = new System.Drawing.Size(734, 22);
            this.statusStripDsPic.TabIndex = 4;
            this.statusStripDsPic.Text = "statusStrip1";
            // 
            // distancePlotToolStripMenuItem
            // 
            this.distancePlotToolStripMenuItem.Image = global::dsPicDesktop.Properties.Resources.distanceplot;
            this.distancePlotToolStripMenuItem.Name = "distancePlotToolStripMenuItem";
            this.distancePlotToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.distancePlotToolStripMenuItem.Text = "Distance Plot";
            this.distancePlotToolStripMenuItem.Click += new System.EventHandler(this.distancePlotToolStripMenuItem_Click);
            // 
            // toolStripButtonDistancePlot
            // 
            this.toolStripButtonDistancePlot.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.toolStripButtonDistancePlot.Image = global::dsPicDesktop.Properties.Resources.distanceplot;
            this.toolStripButtonDistancePlot.ImageScaling = System.Windows.Forms.ToolStripItemImageScaling.None;
            this.toolStripButtonDistancePlot.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.toolStripButtonDistancePlot.Name = "toolStripButtonDistancePlot";
            this.toolStripButtonDistancePlot.Size = new System.Drawing.Size(52, 52);
            this.toolStripButtonDistancePlot.Text = "toolStripButton1";
            this.toolStripButtonDistancePlot.Click += new System.EventHandler(this.toolStripButtonDistancePlot_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 55);
            // 
            // frmDsPic
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(734, 484);
            this.Controls.Add(this.statusStripDsPic);
            this.Controls.Add(this.toolStripDsPic);
            this.Controls.Add(this.menuStripDsPic);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStripDsPic;
            this.Name = "frmDsPic";
            this.Text = "DsPic Gui";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.menuStripDsPic.ResumeLayout(false);
            this.menuStripDsPic.PerformLayout();
            this.toolStripDsPic.ResumeLayout(false);
            this.toolStripDsPic.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStripDsPic;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dsPicToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem serialToolStripMenuItem;
        private System.Windows.Forms.ToolStrip toolStripDsPic;
        private System.Windows.Forms.ToolStripButton toolStripButtonSerialPort;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.StatusStrip statusStripDsPic;
        private System.Windows.Forms.ToolStripMenuItem distanceMeterToolStripMenuItem;
        private System.Windows.Forms.ToolStripButton toolStripButtonDistanceMeter;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripMenuItem distancePlotToolStripMenuItem;
        private System.Windows.Forms.ToolStripButton toolStripButtonDistancePlot;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
    }
}

