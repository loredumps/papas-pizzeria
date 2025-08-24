class roygame.models.customers.Customer25 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 25;
   var customername = "Franco";
   var orders = [[],[[[8,1,1,1,1],[0],[0],[0],[0],[3,1,0,1,1],[0],4,8]]];
   function Customer25(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 25 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
