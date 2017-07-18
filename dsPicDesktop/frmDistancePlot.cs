using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ZedGraph;
using dsPic.SerialPorts;

namespace dsPicDesktop
{
    public partial class frmDistancePlot : Form, HPortListener
    {
        private delegate void PortDataReceivedDelegate();
        private Queue<DistanceDataPoint> mDataQueue = new Queue<DistanceDataPoint>();
        private DataTable mDataTable=new DataTable();
        private string mTempData="";
        public frmDistancePlot()
        {
            SerialPortManager.Instance.AddPortListener(this);
            InitializeComponent();
        }

        public void PortDataReceived()
        {
            mTempData += SerialPortManager.Instance.ReadExisting();
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

        public void RefreshPICData()
        {
            GraphPane myPane = zedGraphControl1.GraphPane;
             myPane.CurveList.Clear();

             PointPairList list1 = new PointPairList();
            DistanceDataPoint[] ddp_array = mDataQueue.ToArray();
            for (int i = 0; i < ddp_array.Length; i++)
            {
                DistanceDataPoint ddp = ddp_array[ddp_array.Length - 1 - i];
                if (ddp.IsTooFar)
                {
                    list1.Add(i, 0);
                }
                else
                {
                    list1.Add(i, ddp.Distance);
                }
            }

      
            LineItem myCurve = myPane.AddCurve("Distance Meter",
                  list1, Color.Red, SymbolType.Diamond);

            /*
            LineItem myCurve2 = myPane.AddCurve("Piper",
                  list2, Color.Blue, SymbolType.Circle);*/

            // Tell ZedGraph to refigure the

            // axes since the data have changed

            zedGraphControl1.AxisChange();
            zedGraphControl1.Refresh();
        }

        private void SetSize()
        {
            zedGraphControl1.Location = new Point(10, 30);
            // Leave a small margin around the outside of the control

            zedGraphControl1.Size = new Size(ClientRectangle.Width - 20,
                                    ClientRectangle.Height - 40);
        }

        private void CreateGraph(ZedGraphControl zgc)
        {
            // get a reference to the GraphPane

            GraphPane myPane = zgc.GraphPane;

            // Set the Titles

            myPane.Title.Text = "Distance Plot";
            myPane.XAxis.Title.Text = "Step";
            myPane.YAxis.Title.Text = "Distance";

           
        }

        private void frmDistancePlot_Load(object sender, EventArgs e)
        {
            CreateGraph(zedGraphControl1);
            // Size the control to fill the form with a margin

            SetSize();
        }

        private void frmDistancePlot_Resize(object sender, EventArgs e)
        {
            SetSize();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            RefreshPICData();
        }
    }
}