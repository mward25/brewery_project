using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using MMABooksEFClasses.MarisModels;
using Microsoft.EntityFrameworkCore;

namespace MMABooksTests
{
    [TestFixture]
    public class StateTests
    {
        
        MMABooksContext dbContext;
        State s;
        List<State> states;

        [SetUp]
        public void Setup()
        {
            dbContext = new MMABooksContext();
            dbContext.Database.ExecuteSqlRaw("CALL usp_testingResetData()");
        }

        [Test]
        public void GetAllTest()
        {
            states = dbContext.States.OrderBy(s => s.StateName).ToList();
            Assert.AreEqual(53, states.Count);
            Assert.AreEqual("Alabama", states[0].StateName);
            PrintAll(states);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            s = dbContext.States.Find("OR");
            Assert.IsNotNull(s);
            Assert.AreEqual("Oregon", s.StateName);
            Console.WriteLine(s);
        }

        [Test]
        public void GetUsingWhere()
        {
            // current version generates a null processing error StartsWith can't operate on a nullable value
            states = dbContext.States.Where(s => s.StateName == "Oregon").OrderBy(s => s.StateName).ToList();
            Assert.AreEqual(1, states.Count);
            Assert.AreEqual("OR", states[0].StateCode);
            PrintAll(states);
        }

        [Test]
        public void GetWithCustomersTest()
        {
            s = dbContext.States.Include("Customers").Where(s => s.StateCode == "OR").SingleOrDefault();
            Assert.IsNotNull(s);
            Assert.AreEqual("Oregon", s.StateName);
            Assert.AreEqual(5, s.Customers.Count);
            Console.WriteLine(s);
        }

        [Test]
        public void DeleteTest()
        {
            s = dbContext.States.Find("HI");
            dbContext.States.Remove(s);
            dbContext.SaveChanges();
            Assert.IsNull(dbContext.States.Find("HI"));
        }

        [Test]
        public void CreateTest()
        {

                    s = new State();
                    s.StateCode = "??";
                    s.StateName = "Confused";
                    dbContext.Add(s);
                    dbContext.SaveChanges();
                    
                    string stateC = s.StateCode;
                    string stateN = s.StateName;

                    s = dbContext.States.Find("??");
                    Assert.AreEqual(s.StateCode, stateC);
                    Assert.AreEqual(s.StateName, stateN);
        }

        [Test]
        public void UpdateTest()
        {
            s = dbContext.States.Find("T");
            string oCode = s.StateCode;
            string oName = s.StateName;

            s.StateCode = "T";
            s.StateName = "10 a c";
            
            string nCode = s.StateCode;
            string nName = s.StateName;

            dbContext.Update(s);
            dbContext.SaveChanges();
            
            
            s = dbContext.States.Find("T");
            
            Assert.AreEqual(s.StateName, nName);

            Assert.AreNotEqual(s.StateName, oName);
        }

        public void PrintAll(List<State> states)
        {
            foreach (State s in states)
            {
                Console.WriteLine(s);
            }
        }
        
    }
}
