class roygame.models.customers.Customer15 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 15;
   var customername = "Greg";
   var orders = [[],[[[6,0,1,1,1],[0],[4,0,0,1,0],[0],[0],[0],[0],4,4]]];
   function Customer15(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 15 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
