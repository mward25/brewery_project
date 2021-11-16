using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class Address
    {
        public Address()
        {
            SupplierAddresses = new HashSet<SupplierAddress>();
        }

        public int AddressId { get; set; }
        public string StreetLine1 { get; set; }
        public string StreetLine2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zipcode { get; set; }
        public string Country { get; set; }

        public virtual ICollection<SupplierAddress> SupplierAddresses { get; set; }
    }
}
