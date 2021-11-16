using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class ContainerSize
    {
        public ContainerSize()
        {
            BrewContainers = new HashSet<BrewContainer>();
        }

        public int ContainerSizeId { get; set; }
        public string Name { get; set; }
        public double? MaxVolume { get; set; }
        public double? WorkingVolume { get; set; }

        public virtual ICollection<BrewContainer> BrewContainers { get; set; }
    }
}
