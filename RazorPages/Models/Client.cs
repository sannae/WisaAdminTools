using System;
using System.ComponentModel.DataAnnotations;

namespace RazorPagesClient.Models
{
    public class Client
    {
        public int ID { get; set; }
        public DateTime UpdateDate { get; set; }
        [DataType(DataType.Date)]
        public string Customer { get; set; }
        public string VPNClient { get; set; }
        public string VPNGateway { get; set; }
        public string VPNusername { get; set; }
        public string VPNpassword { get; set; }
        public string RDPaddress { get; set; }
        public string RDPusername { get; set; }
        public string RDPpassword { get; set; }
    }
}