
include('tool.js')
require('JPEngine').addExtensions(['JPMemory'])
defineClass('ButtonInstance', {
            p5: function(sender) {
            require('UIView, DQAlertView,UIColor,UITapGestureRecognizer,UIApplication')
            var arr = require('NSMutableArray').alloc().init()
            arr.addObject("JS")
            jsArr = arr.toJS()
            console.log(jsArr.push("Patch"))  //output
            var person = require('Person').alloc().init()
            person.name = "f";
            person.age = (30);

            console.log(person)
            var mycars=new Array()
            mycars[0]="Saab"
            mycars[1]="Volvo"
            mycars[2]="BMW"
            mycars.join(".")
             console.log(mycars)
            
//            var alertView = require('UIAlertView').alloc().init();
//            alertView.setTitle('Alert');
//            alertView.setMessage('AlertView from js');
//            alertView.addButtonWithTitle('OK');
//            
//            alertView.show();
            
            var person = require('Person').alloc().init();
             person.name = "ff";
            person.test = "gg";
            person.age = 30;
//            var alterview1 = DQAlertView.alloc().initWithTitle_message_cancelButtonTitle_otherButtonTitle("title","message","other","ok");
//            
//            alertView1.show();
         //   require('SVProgressHUD').show()

//
            }
            })

defineClass('AppDelegate', {
            replaceMethodWithJSPatch: function() {
            
           var yearString = "1986-05-04 00:59:01";
            var dateFormatter = require('NSDateFormatter').dateFormatterWithFormat_timeZone('yyyy-MM-dd HH:mm:ss', require('NSTimeZone').timeZoneWithAbbreviation('UTC'));
                       
            //dateFormatter.setDateFormat('yyyy-MM-dd HH:mm:ss');
           // var timeZone = require('NSTimeZone').timeZoneWithAbbreviation('UTC');
            var userDate = dateFormatter.dateFromString(yearString);
            console.log(userDate);
            
           return userDate;

            }
            })


function isArray(obj) {
    return Object.prototype.toString.call(obj) === '[object Array]';
}

//defineClass('AppDelegate', {
//            isArray: function(obj) {
//            return Object.prototype.toString.call(obj) === '[object Array]';
//            }
//            })


defineClass('AppDelegate', {
            testJS: function() {
           
            // GCD
            self.ORIGtestJS();
            dispatch_after(1.0, function(){
                           console.log('message')
                           });
            dispatch_async_main(function(){
                                // do something
                                });
            
            dispatch_async_global_queue(function(){
                                        console.log("dispatch_async_global_queue");
                                        });
            
            var arr1 = ["1","2"];
            var t1 = "hello";
            var t3 = typeof(t1);
            var t4 = isArray(t1);
            console.log(t4);
            
            

            console.log(t3);

            }
            })
