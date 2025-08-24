class roygame.models.customers.Customer12 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 12;
   var customername = "Allan";
   var orders = [[],[[[4,1,0,0,1],[4,0,1,1,0],[0],[0],[0],[0],[0],4,6]]];
   function Customer12(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 12 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
