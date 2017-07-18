namespace dsPicDesktop
{
    partial class frmDistanceMeter
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
            this.grpDistanceDataForm = new System.Windows.Forms.GroupBox();
            this.dgvDistanceDataForm = new System.Windows.Forms.DataGridView();
            this.grpDistanceDataForm.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDistanceDataForm)).BeginInit();
            this.SuspendLayout();
            // 
            // grpDistanceDataForm
            // 
            this.grpDistanceDataForm.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.grpDistanceDataForm.Controls.Add(this.dgvDistanceDataForm);
            this.grpDistanceDataForm.Location = new System.Drawing.Point(12, 12);
            this.grpDistanceDataForm.Name = "grpDistanceDataForm";
            this.grpDistanceDataForm.Size = new System.Drawing.Size(451, 469);
            this.grpDistanceDataForm.TabIndex = 0;
            this.grpDistanceDataForm.TabStop = false;
            this.grpDistanceDataForm.Text = "Distance Data Form";
            // 
            // dgvDistanceDataForm
            // 
            this.dgvDistanceDataForm.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.dgvDistanceDataForm.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.DisplayedCells;
            this.dgvDistanceDataForm.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDistanceDataForm.Location = new System.Drawing.Point(6, 19);
            this.dgvDistanceDataForm.Name = "dgvDistanceDataForm";
            this.dgvDistanceDataForm.Size = new System.Drawing.Size(436, 444);
            this.dgvDistanceDataForm.TabIndex = 0;
            // 
            // frmDistanceMeter
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(472, 493);
            this.Controls.Add(this.grpDistanceDataForm);
            this.Name = "frmDistanceMeter";
            this.Text = "Distance Meter";
            this.grpDistanceDataForm.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDistanceDataForm)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox grpDistanceDataForm;
        private System.Windows.Forms.DataGridView dgvDistanceDataForm;
    }
}