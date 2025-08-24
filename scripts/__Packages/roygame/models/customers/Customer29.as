class roygame.models.customers.Customer29 extends roygame.models.Customer
{
   var clipname = "customer";
   var customertype = 29;
   var customername = "Hugo";
   var orders = [[],[[[0],[4,1,1,0,0],[0],[4,0,1,0,0],[0],[0],[0],4,6]]];
   function Customer29(gameobj, num)
   {
      super();
      var _loc3_ = this;
      _loc3_.gameObj = gameobj;
      _loc3_.number = num;
      trace("new customer 29 added");
      _loc3_.setupCustomer();
      _loc3_.startCustomerEntering();
   }
}
