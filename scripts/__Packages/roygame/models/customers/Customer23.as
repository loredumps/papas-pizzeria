class roygame.models.customers.Customer23 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 23;
   var customername = "Sasha";
   var orders = [[],[[[0],[0],[0],[4,0,1,0,0],[0],[8,1,1,1,1],[0],4,8]]];
   function Customer23(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 23 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
