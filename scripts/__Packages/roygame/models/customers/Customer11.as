class roygame.models.customers.Customer11 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 11;
   var customername = "Sue";
   var orders = [[],[[[6,1,0,0,1],[0],[6,0,1,1,0],[0],[0],[0],[0],3,6]]];
   function Customer11(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 11 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
