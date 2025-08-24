class roygame.models.customers.Customer8 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 8;
   var customername = "Penny";
   var orders = [[],[[[0],[8,1,1,1,1],[2,1,0,0,0],[0],[0],[0],[0],2,6]]];
   function Customer8(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 8 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
