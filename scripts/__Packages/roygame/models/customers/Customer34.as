class roygame.models.customers.Customer34 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 34;
   var customername = "Bruna Romano";
   var orders = [[],[[[2,1,0,0,0],[4,1,1,1,1],[0],[0],[0],[4,1,1,1,1],[0],5,4]]];
   function Customer34(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 34 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
