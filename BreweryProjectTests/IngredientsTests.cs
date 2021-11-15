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
                Console.WriteLine("if this test fails, it means something is fundumentaly wrong with nUnit.");
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

        [Test]
        public void CreateTest()
        {
            theIngredient = new Ingredient();
            theIngredient.Name = "Wheat";
            theIngredient.Quantity = 2;
            dbContext.Add(theIngredient);
            dbContext.SaveChanges();
            
            int theIngredientID = theIngredient.IngredientId;
            string theName = theIngredient.Name;
            int theQuant = theIngredient.Quantity;

            theIngredient = dbContext.Ingredients.Find(theIngredientID);
            Assert.AreEqual(theIngredient.Quantity, theQuant);
            Assert.AreEqual(theIngredient.Name, theName);
        }

        [Test]
        public void UpdateTest()
        {
            theIngredient = dbContext.Ingredients.Find(2);
            string oName = theIngredient.Name;
            int oQuant = theIngredient.Quantity;

            theIngredient.Name = "Beets";
            theIngredient.Quantity = 30;
            
            string nName = theIngredient.Name;
            int nQuant = theIngredient.Quantity;

            dbContext.Update(theIngredient);
            dbContext.SaveChanges();
            
            
            theIngredient = dbContext.Ingredients.Find(2);
            
            Assert.AreEqual(theIngredient.Name, nName);

            Assert.AreNotEqual(theIngredient.Quantity, oName);
        }

        public void PrintAll(List<Ingredient> ingredients)
        {
            foreach (Ingredient theIngredient in ingredients)
            {
                Console.WriteLine(theIngredient.Name);
            }
        }
        
    }
}
