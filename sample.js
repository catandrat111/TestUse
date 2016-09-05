defineClass('ButtonInstance', {
            p5: function(sender) {
            
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
            
            var alertView = require('UIAlertView').alloc().init();
            alertView.setTitle('Alert');
            alertView.setMessage('AlertView from js');
            alertView.addButtonWithTitle('OK');
            alertView.show();
            }
            })
