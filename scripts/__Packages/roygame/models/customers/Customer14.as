class roygame.models.customers.Customer14 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 14;
   var customername = "Chuck";
   var orders = [[],[[[8,1,1,1,1],[4,0,1,1,0],[0],[0],[0],[0],[0],2,6]]];
   function Customer14(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 14 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
