using System;
using System.Collections.Generic;

#nullable disable

namespace BreweryProjectEFCore.Models
{
    public partial class BrewContainer
    {
        public BrewContainer()
        {
            BatchContainers = new HashSet<BatchContainer>();
        }

        public int BrewContainerId { get; set; }
        public string Name { get; set; }
        public int ContainerStatusId { get; set; }
        public int ContainerTypeId { get; set; }
        public int ContainerSizeId { get; set; }

        public virtual ContainerSize ContainerSize { get; set; }
        public virtual ContainerStatus ContainerStatus { get; set; }
        public virtual ContainerType ContainerType { get; set; }
        public virtual Barrel Barrel { get; set; }
        public virtual ICollection<BatchContainer> BatchContainers { get; set; }
    }
}
