using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using dsPic;
using dsPic.SerialPorts;
using System.IO.Ports;


namespace dsPicDesktop
{
    public partial class frmDistanceMeter : Form, HPortListener
    {
        private delegate void PortDataReceivedDelegate();
        private Queue<DistanceDataPoint> mDataQueue = new Queue<DistanceDataPoint>();
        private DataTable mDataTable=new DataTable();
        private string mTempData="";

        public frmDistanceMeter()
        {
            SerialPortManager.Instance.AddPortListener(this);
            InitializeComponent();
        }

       

        public void PortDataReceived()
        {
            mTempData+=SerialPortManager.Instance.ReadExisting();
            if (mTempData.Contains("|"))
            {
                mTempData = mTempData.Trim();
                mTempData = mTempData.Replace("cm|", "");
                DistanceDataPoint dp = new DistanceDataPoint();
                dp.Distance = int.Parse(mTempData);
                if (mTempData.Contains("Too Far"))
                {
                    dp.IsTooFar = true;
                }
                mDataQueue.Enqueue(dp);

                if (mDataQueue.Count > 50)
                {
                    mDataQueue.Dequeue();
                }
                mTempData = "";

                if (this.InvokeRequired)
                {
                    this.Invoke(new PortDataReceivedDelegate(RefreshPICData));
                }
                else
                {
                    RefreshPICData();
                }
            }
        }

        private void RefreshPICData()
        {
            mDataTable = new DataTable();
            mDataTable.Columns.Add("Distance");
            mDataTable.Columns.Add("Time");
            DistanceDataPoint[] ddp_array = mDataQueue.ToArray();
            for (int i = ddp_array.Length - 1; i >= 0; i--)
            {
                DistanceDataPoint ddp=ddp_array[i];
                if (ddp.IsTooFar)
                {
                    mDataTable.Rows.Add("Too Far", ddp.Time.ToString());
                }
                else
                {
                    mDataTable.Rows.Add(string.Format("{0} cm", ddp.Distance), ddp.Time.ToLongTimeString());
                }

            }
            dgvDistanceDataForm.DataSource = mDataTable;
        }

        
    }
}