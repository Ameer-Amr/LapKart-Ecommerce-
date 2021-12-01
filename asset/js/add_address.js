console.log('successs')


$("#add_address").validate({
    rules:{
        first_name:{
            required:true,
            minlength:4,
            maxlength:10,
        },
        last_name:{
            required:true,
            minlength:4,
            maxlength:10,
        },  
        email:{
            required:true,
            email:true,

        },
        phone_number: {
            matches:"(([0-9]{10})|(\([0-9]{3}\)\s+[0-9]{3}\-[0-9]{4}))",
            minlength:10, 
            maxlength:10,

        },    
        pincode:{
            required:true,
            minlength:6,
            maxlength:6 ,
        },
        address_line_1:{
            required:true,
            minlength:10,
            maxlength:100,
        },
        address_line_2:{
            required:true,
            minlength:10,
            maxlength:100,
        },
        city:{
            required:true,
            minlength:4,
            maxlength:20,
        },
        state:{
            required:true,
            minlength:3,
            maxlength:15,
        },
        country:{
            required:true,
            minlength:3,
            maxlength:15,
        },
        address_type:{
            required:true,
        }
    },
    messages:{
        first_name:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        last_name:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        email:{
            email:"Invalid Email Address",
        },
        phone_number:{
            minlength:"The Minimum Number of Characters should be 10",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        pincode:{
            minlength:"The Minimum Number of Characters should be 6",
            maxlength:"The Maximum Number of Characters should be 6",
        },
        address_line_1:{
            minlength:"The Minimum Number of Characters should be 10",
            maxlength:"The Maximum Number of Characters should be 100",
        },
        address_line_2:{
            minlength:"The Minimum Number of Characters should be 10",
            maxlength:"The Maximum Number of Characters should be 100",
        },
        city:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 20",
        },
        state:{
            minlength:"The Minimum Number of Characters should be 3",
            maxlength:"The Maximum Number of Characters should be 15",
        },
        country:{
            minlength:"The Minimum Number of Characters should be 3",
            maxlength:"The Maximum Number of Characters should be 15",
        },
        

    }

})

