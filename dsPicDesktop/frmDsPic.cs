using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace dsPicDesktop
{
    public partial class frmDsPic : Form
    {
        public frmDsPic()
        {
            InitializeComponent();
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void serialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSerialPort frm = new frmSerialPort();
            frm.MdiParent = this;
            frm.Show();
        }

        private void toolStripButtonSerialPort_Click(object sender, EventArgs e)
        {
            frmSerialPort frm = new frmSerialPort();
            frm.MdiParent = this;
            frm.Show();
        }

        private void distanceMeterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDistanceMeter frm = new frmDistanceMeter();
            frm.MdiParent = this;
            frm.Show();
        }

        private void toolStripButtonDistanceMeter_Click(object sender, EventArgs e)
        {
            frmDistanceMeter frm = new frmDistanceMeter();
            frm.MdiParent = this;
            frm.Show();
        }

        private void distancePlotToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDistancePlot frm = new frmDistancePlot();
            frm.MdiParent = this;
            frm.Show();
        }

        private void toolStripButtonDistancePlot_Click(object sender, EventArgs e)
        {
            frmDistancePlot frm = new frmDistancePlot();
            frm.MdiParent = this;
            frm.Show();
        }
    }
}