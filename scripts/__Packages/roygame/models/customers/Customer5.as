class roygame.models.customers.Customer5 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 5;
   var customername = "Kingsley";
   var orders = [[],[[[8,1,1,1,1],[0],[0],[0],[0],[0],[0],4,4]]];
   function Customer5(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 5 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
