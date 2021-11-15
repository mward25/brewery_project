using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using MMABooksEFClasses.MarisModels;
using Microsoft.EntityFrameworkCore;

namespace MMABooksTests
{
    [TestFixture]
    public class ProductTests
    {
    
            MMABooksContext dbContext;
            Products p;
            List<Products> products;

            [SetUp]
            public void Setup()
            {
		// Reset database
                dbContext = new MMABooksContext();
                dbContext.Database.ExecuteSqlRaw("CALL usp_testingResetData()");
            }

            [Test]
            public void GetAllTest()
            {
                    products = dbContext.Products.OrderBy(p => p.ProductCode).ToList();
                    Assert.AreEqual(16, products.Count);
                    Assert.AreEqual("A4CS", products[0].ProductCode);
                    PrintAll(products);
            }

            [Test]
            public void GetByPrimaryKeyTest()
            {
                    p = dbContext.Products.Find("DB1R");
                    Assert.IsNotNull(p);
                    Assert.AreEqual("DB2 for the COBOL Programmer, Part 1 (2nd Edition)", p.Description);
                    Console.WriteLine(p);
            }

            [Test]
            public void GetUsingWhere()
            {
                // get a list of all of the products that have a unit price of 56.50
                products = dbContext.Products.Where((p => p.UnitPrice == 56.50m)).ToList();
                Assert.IsNotNull(products);

                foreach (Products item in products)
                {
                        Assert.AreEqual(56.50m, item.UnitPrice);
                }

            }

            [Test]
            public void GetWithCalculatedFieldTest()
            {
                // get a list of objects that include the productcode, unitprice, quantity and inventoryvalue
                var products = dbContext.Products.Select(
                p => new { p.ProductCode, p.UnitPrice, p.OnHandQuantity, Value = p.UnitPrice * p.OnHandQuantity }).
                OrderBy(p => p.ProductCode).ToList();
                Assert.AreEqual(16, products.Count);
            }

            [Test]
            public void DeleteTest()
            {
                    p = dbContext.Products.Find("ADC4");
                    dbContext.Products.Remove(p);
                    dbContext.SaveChanges();
                    Assert.IsNull(dbContext.Products.Find("ADC4"));
            }

            [Test]
            public void CreateTest()
            {
                    Products newProduct = new Products();
                    newProduct.ProductCode = "POTA";
                    newProduct.Description = "TO";
                    newProduct.UnitPrice = 3.030m;
                    newProduct.OnHandQuantity = 222;

                    string oProductCode = "POTA";
                    string oDescription = "TO";
                    decimal oUnitPrice = 3.030m;
                    int oOnHandQuantity = 222;

                    dbContext.Add(newProduct);
                    dbContext.SaveChanges();
                    p = dbContext.Products.Find("POTA");
                    
                    Assert.AreEqual(oProductCode, p.ProductCode);
                    Assert.AreEqual(oDescription, p.Description);
                    Assert.AreEqual(oUnitPrice, p.UnitPrice);
                    Assert.AreEqual(oOnHandQuantity, p.OnHandQuantity);

            }

            [Test]
            public void UpdateTest()
            {


                    p = dbContext.Products.Find("CRFC");
                    string pproduct = p.ProductCode;
                    string pdesc = p.Description;
                    decimal punit = p.UnitPrice;
                    int ponhand = p.OnHandQuantity;

                    p.Description = "ha ha, I changed the description";
                    p.UnitPrice = 39.32m;
                    dbContext.Products.Update(p);
                    dbContext.SaveChanges();
                    
                    
                    p = dbContext.Products.Find("CRFC");
                    
                    Assert.AreNotEqual(p.Description, pdesc);
                    Assert.AreNotEqual(p.UnitPrice, punit);
                    Assert.AreEqual(p.ProductCode, pproduct);
                    Assert.AreEqual(p.OnHandQuantity, ponhand);
            }
            
            public void PrintAll(List<Products> products)
            {
                foreach (Products p in products)
                {
                    Console.WriteLine(p);
                }
            }
    }
}
