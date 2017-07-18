using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using dsPic.SerialPorts;
using System.IO.Ports;

namespace dsPicDesktop
{
    public partial class frmSerialPort : Form, HPortListener
    {
        private delegate void PortDataReceivedDelegate();
        private string mPICText = "";
        private PICDataFormat mFormat=PICDataFormat.ASCII;

        public enum PICDataFormat
        {
            ASCII,
            HEX,
            DEC,
            BIN
        };

        public frmSerialPort()
        {
            SerialPortManager.Instance.AddPortListener(this);
            InitializeComponent();
        }

        private void frmSerialPort_Load(object sender, EventArgs e)
        {
            List<HSerialPort> ports=SerialPortManager.Instance.Ports;
            cboSerialPorts.DataSource = ports;
            if (ports.Count != 0)
            {
                cboSerialPorts.SelectedIndex = 0;
            }
            cboBaudRate.DataSource = SerialPortManager.Instance.BaudRates;
            cboBaudRate.SelectedItem = SerialPortManager.Instance.HBaudRate; 
            cboStopBits.DataSource = SerialPortManager.Instance.StopBits;
            cboStopBits.SelectedItem = SerialPortManager.Instance.HStopBits;
            cboParities.DataSource = SerialPortManager.Instance.Parities;
            cboParities.SelectedItem = SerialPortManager.Instance.HParity;
            cboDataBits.DataSource = SerialPortManager.Instance.DataBits;
            cboDataBits.SelectedItem = SerialPortManager.Instance.HDataBits;

            cboPICDataFormat.Items.Add(PICDataFormat.ASCII);
            cboPICDataFormat.Items.Add(PICDataFormat.HEX);
            cboPICDataFormat.Items.Add(PICDataFormat.DEC);
            cboPICDataFormat.Items.Add(PICDataFormat.BIN);

            cboPICDataFormat.SelectedItem = PICDataFormat.ASCII;

            btnDisconnect.Enabled = false;
            btnConnect.Enabled = true;
            btnPCSend.Enabled = false;
        }

        private void cboSerialPorts_SelectedIndexChanged(object sender, EventArgs e)
        {
            HSerialPort port = (HSerialPort)cboSerialPorts.SelectedItem;
            if (port.IsActive)
            {
                this.picPortActive.Image = global::dsPicDesktop.Properties.Resources.tick;
            }
            else
            {
                this.picPortActive.Image = global::dsPicDesktop.Properties.Resources.cross;
            }
            webPortDesc.DocumentText = port.Html;
        }

        private void btnPCClear_Click(object sender, EventArgs e)
        {
            txtPC.Text = "";
        }

        private void btnPICClear_Click(object sender, EventArgs e)
        {
            txtPIC.Text = "";
            mPICText = "";
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            btnConnect.Enabled = false;
            btnDisconnect.Enabled = true;
            btnPCSend.Enabled = true;

            SerialPortManager spm = SerialPortManager.Instance;

            spm.HSerialPort = (HSerialPort)cboSerialPorts.SelectedItem;
            spm.HBaudRate = (HBaudRate)cboBaudRate.SelectedItem;
            spm.HParity = (HParity)cboParities.SelectedItem;
            spm.HDataBits = (HDataBits)cboDataBits.SelectedItem;
            spm.HStopBits = (HStopBits)cboStopBits.SelectedItem;

            

            spm.Connect();
        }

        public void PortDataReceived()
        {
            mPICText += SerialPortManager.Instance.ReadExisting();
            if (this.InvokeRequired)
            {
                this.Invoke(new PortDataReceivedDelegate(RefreshPICData));
            }
            else
            {
                RefreshPICData();
            }
        }

        private void btnDisconnect_Click(object sender, EventArgs e)
        {
            btnConnect.Enabled = true;
            btnDisconnect.Enabled = false;
            btnPCSend.Enabled = false;

            SerialPortManager.Instance.Disconnect();
        }

        private void btnPCSend_Click(object sender, EventArgs e)
        {
            if(!SerialPortManager.Instance.Send(txtPC.Text))
            {
                MessageBox.Show("Port not open!");
            }
        }

        private void RefreshPICData()
        {
            if (chkTruncate.Checked)
            {
                if (mPICText.Length > 200)
                {
                    mPICText = mPICText.Substring(mPICText.Length - 200);
                }
            }

            mFormat = (PICDataFormat)cboPICDataFormat.SelectedItem;
            if (mFormat == PICDataFormat.ASCII)
            {
                txtPIC.Text = mPICText;
                return;
            }
            StringBuilder sb = new StringBuilder();
            int length = mPICText.Length;
            if (mFormat == PICDataFormat.DEC)
            {
                for (int i = 0; i != length; ++i)
                {
                    sb.AppendFormat("{0} ", (int)mPICText[i]);
                }
            }
            else if (mFormat == PICDataFormat.BIN)
            {
                for (int i = 0; i != length; ++i)
                {
                    sb.AppendFormat("{0:x} ", Convert.ToString(mPICText[i], 2));
                }
            }
            else if (mFormat == PICDataFormat.HEX)
            {
                for (int i = 0; i != length; ++i)
                {
                    sb.AppendFormat("{0:x} ", (int)mPICText[i]);
                }
            }

            txtPIC.Text = sb.ToString();
        }

        private void btnRefreshPICData_Click(object sender, EventArgs e)
        {
            RefreshPICData();
        }

        private void frmSerialPort_FormClosed(object sender, FormClosedEventArgs e)
        {
           
        }
    }
}