using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace Wmi
{
    class XMLConfig
    {
        public static List<string> GetSettings(string WMIClassName)
        {
            string parent_path = Connection.ApplicationPath;
            if (parent_path == "")
            {
                parent_path = System.IO.Directory.GetCurrentDirectory();
            }
            string xmlFilePath = parent_path + "\\settings.xml";
            List<string> alPropertyNames = new List<string>();
            System.Xml.XmlDocument xmldoc = new System.Xml.XmlDocument();
            xmldoc.Load(xmlFilePath);
            System.Xml.XmlNode properties = xmldoc.SelectSingleNode("//" + WMIClassName);

            for (int i = 0; i < properties.ChildNodes.Count; i++)
                alPropertyNames.Add(properties.ChildNodes[i].InnerText);
            return alPropertyNames;
        }
    }
}
