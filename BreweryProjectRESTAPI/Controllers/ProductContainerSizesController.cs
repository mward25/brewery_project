using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BreweryProjectEFCore.Models;

namespace BreweryProjectRESTAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductContainerSizesController : ControllerBase
    {
        private readonly BreweryProjectContext _context;

        public ProductContainerSizesController(BreweryProjectContext context)
        {
            _context = context;
        }

        // GET: api/ProductContainerSizes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductContainerSize>>> GetProductContainerSizes()
        {
            return await _context.ProductContainerSizes.ToListAsync();
        }

        // GET: api/ProductContainerSizes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ProductContainerSize>> GetProductContainerSize(int id)
        {
            var productContainerSize = await _context.ProductContainerSizes.FindAsync(id);

            if (productContainerSize == null)
            {
                return NotFound();
            }

            return productContainerSize;
        }

        // PUT: api/ProductContainerSizes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProductContainerSize(int id, ProductContainerSize productContainerSize)
        {
            if (id != productContainerSize.ContainerSizeId)
            {
                return BadRequest();
            }

            _context.Entry(productContainerSize).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductContainerSizeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ProductContainerSizes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ProductContainerSize>> PostProductContainerSize(ProductContainerSize productContainerSize)
        {
            _context.ProductContainerSizes.Add(productContainerSize);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetProductContainerSize", new { id = productContainerSize.ContainerSizeId }, productContainerSize);
        }

        // DELETE: api/ProductContainerSizes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProductContainerSize(int id)
        {
            var productContainerSize = await _context.ProductContainerSizes.FindAsync(id);
            if (productContainerSize == null)
            {
                return NotFound();
            }

            _context.ProductContainerSizes.Remove(productContainerSize);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ProductContainerSizeExists(int id)
        {
            return _context.ProductContainerSizes.Any(e => e.ContainerSizeId == id);
        }
    }
}
