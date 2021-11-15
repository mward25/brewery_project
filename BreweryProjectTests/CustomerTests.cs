using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using MMABooksEFClasses.MarisModels;
using Microsoft.EntityFrameworkCore;

namespace MMABooksTests
{
    [TestFixture]
    public class CustomerTests
    {
        
        MMABooksContext dbContext;
        Customer c;
        List<Customer> customers;

        [SetUp]
        public void Setup()
        {
            // Reset database
            dbContext = new MMABooksContext();
            dbContext.Database.ExecuteSqlRaw("call usp_testingResetData()");
        }

	/// <summary>
	/// gets all customers as a list and verifies them
	/// <\summary>
        [Test]
        public void GetAllTest()
        {
                customers = dbContext.Customers.OrderBy(c => c.CustomerId).ToList();
                Assert.AreEqual(696, customers.Count);
                Assert.AreEqual("Molunguri, A", customers[0].Name);
                PrintAll(customers);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
                c = dbContext.Customers.Find(696);
                Assert.IsNotNull(c);
                Assert.AreEqual("Smith, Lawrence", c.Name);
                Console.WriteLine(c);
        }

        [Test]
        public void GetUsingWhere()
        {
            // get a list of all of the customers who live in OR
            customers = dbContext.Customers.Where(c => c.StateCode=="OR").ToList();
            foreach( Customer theCust in customers)
            {
                    Assert.AreEqual(theCust.StateCode, "OR");
            }
        }

        [Test]
        public void GetWithInvoicesTest()
        {
            // get the customer whose id is 20 and all of the invoices for that customer
            c = dbContext.Customers.Find(20);
            List<Invoices> invoices = c.Invoices.ToList();

            foreach( Invoices theInvoice in invoices)
            {
                Assert.AreEqual(theInvoice.Customer.CustomerId, c.CustomerId);
            }
        }

        
        public void GetWithJoinTest()
        {
            // get a list of objects that include the customer id, name, statecode and statename
            var customers = dbContext.Customers.Join(
                    dbContext.States,
                    c => c.StateCode,
                    s => s.StateCode,
                    (c, s) => new { c.CustomerId, c.Name, c.StateCode, s.StateName }).OrderBy(r => r.StateName).ToList();
            Assert.AreEqual(696, customers.Count);
        }

        [Test]
        public void DeleteTest()
        {
               c = new Customer();
               c.CustomerId = 1;
               //c = dbContext.Customers.Find(0);

               dbContext.Customers.Remove(c);
               dbContext.SaveChanges();
               Assert.IsNull(dbContext.Customers.Find(1));
        }


        [Test]
        public void CreateTest()
        {
                Customer newCustomer = new Customer();
                newCustomer.Name = "POTA";
                newCustomer.Address = "TO's are nice";
                newCustomer.City = "City City";
                newCustomer.StateCode = "OR";
                newCustomer.ZipCode = "12321";

                string oName = "POTA";
                string oAddress = "TO's are nice";
                string oCity = "City City";
                string oStateCode = "OR";
                string oZipCode = "12321";

                dbContext.Add(newCustomer);
                dbContext.SaveChanges();

                c = dbContext.Customers.Find(newCustomer.CustomerId);
                
                Assert.AreEqual(oName, c.Name);
                Assert.AreEqual(oAddress, c.Address);
                Assert.AreEqual(oCity, c.City);
                Assert.AreEqual(oStateCode, c.StateCode);
                Assert.AreEqual(oZipCode, c.ZipCode);

        }


        [Test]
        public void UpdateTest()
        {
                c = dbContext.Customers.Find(32);
                int ccustomerId = c.CustomerId;
                string caddress = c.Address;
                string cName = c.Name;
                string cCity = c.City;
                string cStateCode = c.StateCode;
                string cZip = c.ZipCode;

                c.Address = "newADDr";
                c.Name = "aaa AAA";
                dbContext.Customers.Update(c);
                dbContext.SaveChanges();
                
                
                c = dbContext.Customers.Find(32);
                
                Assert.AreNotEqual(c.Address, caddress);
                Assert.AreNotEqual(c.Name, cName);
                Assert.AreEqual(c.CustomerId, ccustomerId);
                Assert.AreEqual(c.City, cCity);
                Assert.AreEqual(c.StateCode, cStateCode);
                Assert.AreEqual(c.ZipCode, cZip);
        }

        public void PrintAll(List<Customer> customers)
        {
            foreach (Customer c in customers)
            {
                Console.WriteLine(c);
            }
        }
        
        
    }
}
