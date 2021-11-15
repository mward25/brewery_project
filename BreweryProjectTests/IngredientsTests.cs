using System.Collections.Generic;
using System.Linq;
using System;

using NUnit.Framework;
using BreweryProjectEFCore.Models;
using Microsoft.EntityFrameworkCore;

namespace BreweryProjectTests 
{
    [TestFixture]
    public class IngredientsTests 
    {
        
        //MMABooksContext dbContext;
        BreweryProjectContext dbContext;
        //State s;
        Ingredient theIngredient;
        //List<State> states;
        List<Ingredient> ingredients;

        [SetUp]
        public void Setup()
        {
            dbContext = new BreweryProjectContext();
           try 
           {
                dbContext.Database.ExecuteSqlRaw("CALL usp_testing_reset_data()");
           }
           catch (Exception e)
           {
                Console.WriteLine("you should probobly fix the exception in your code miles!!!");
           }
        }

        [Test]
        public void testTest()
        {
                int a = 5;
                Assert.AreEqual(5, a);
        }

        [Test]
        public void GetAllTest()
        {
            ingredients = dbContext.Ingredients.OrderBy(theIngredient => theIngredient.Name).ToList();
            Assert.AreEqual(3, ingredients.Count);
            Assert.AreEqual("Beets", ingredients[0].Name);
            PrintAll(ingredients);
        }

        [Test]
        public void GetByPrimaryKeyTest()
        {
            theIngredient = dbContext.Ingredients.Find(1);
            Assert.IsNotNull(theIngredient);
            Assert.AreEqual("Horse Radish", theIngredient.Name);
            Console.WriteLine(theIngredient);
        }

        [Test]
        public void GetUsingWhere()
        {
            // current version generates a null processing error StartsWith can't operate on a nullable value
            ingredients = dbContext.Ingredients.Where(theIngredient => theIngredient.Name == "POTATO").OrderBy(theIngredient => theIngredient.Name).ToList();
            Assert.AreEqual(1, ingredients.Count);
            Assert.AreEqual("POTATO", ingredients[0].Name);
            PrintAll(ingredients);
        }

        //[Test]
        //public void GetWithCustomersTest()
        //{
        //    theIngredient = dbContext.Ingredients.Include("Customers").Where(theIngredient => theIngredient.StateCode == "OR").SingleOrDefault();
        //    Assert.IsNotNull(theIngredient);
        //    Assert.AreEqual("Oregon", theIngredient.StateName);
        //    Assert.AreEqual(5, theIngredient.Customers.Count);
        //    Console.WriteLine(theIngredient);
        //}

        [Test]
        public void DeleteTest()
        {
            theIngredient = dbContext.Ingredients.Find(2);
            dbContext.Ingredients.Remove(theIngredient);
            dbContext.SaveChanges();
            Assert.IsNull(dbContext.Ingredients.Find(2));
        }

        //[Test]
        //public void CreateTest()
        //{

        //            theIngredient = new State();
        //            theIngredient.StateCode = "??";
        //            theIngredient.StateName = "Confused";
        //            dbContext.Add(theIngredient);
        //            dbContext.SaveChanges();
        //            
        //            string stateC = theIngredient.StateCode;
        //            string stateN = theIngredient.StateName;

        //            theIngredient = dbContext.Ingredients.Find("??");
        //            Assert.AreEqual(theIngredient.StateCode, stateC);
        //            Assert.AreEqual(theIngredient.StateName, stateN);
        //}

        //[Test]
        //public void UpdateTest()
        //{
        //    theIngredient = dbContext.Ingredients.Find("T");
        //    string oCode = theIngredient.StateCode;
        //    string oName = theIngredient.StateName;

        //    theIngredient.StateCode = "T";
        //    theIngredient.StateName = "10 a c";
        //    
        //    string nCode = theIngredient.StateCode;
        //    string nName = theIngredient.StateName;

        //    dbContext.Update(theIngredient);
        //    dbContext.SaveChanges();
        //    
        //    
        //    theIngredient = dbContext.Ingredients.Find("T");
        //    
        //    Assert.AreEqual(theIngredient.StateName, nName);

        //    Assert.AreNotEqual(theIngredient.StateName, oName);
        //}

        public void PrintAll(List<Ingredient> ingredients)
        {
            foreach (Ingredient theIngredient in ingredients)
            {
                Console.WriteLine(theIngredient.Name);
            }
        }
        
    }
}
