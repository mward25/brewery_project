using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class ProductContainerSize
    {
        public ProductContainerSize()
        {
            InventoryTransactions = new HashSet<InventoryTransaction>();
            Products = new HashSet<Product>();
        }

        public int ContainerSizeId { get; set; }
        public string Name { get; set; }
        public double Volume { get; set; }
        public int ItemQuantity { get; set; }

        public virtual ProductContainerInventory ProductContainerInventory { get; set; }
        public virtual ICollection<InventoryTransaction> InventoryTransactions { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}
