console.log('successs')
$("#register").validate({
    rules:{
        first_name:{
            required:true,

        },
        last_name:{
            required:true,

        },  
        email:{
            required:true,
            email:true,

        },
        phone_number: {
            required:true,
            number:true,
            matches:"(([0-9]{10})|(\([0-9]{3}\)\s+[0-9]{3}\-[0-9]{4}))",
            minlength:10, 
            maxlength:10,

        },    
        password:{
            required:true,
            minlength:4,
            maxlength:10,
        },
        confirm_password:{
            required:true,
            minlength:4,
            maxlength:10,
        }
    },
    messages:{
        first_name:{
            required:"This field is required!",
        },
        last_name:{
            required:"This field is required!",
        },
        email:{
            email:"Invalid Email Address",
        },
        phone_number:{
            minlength:"The Minimum Number of Characters should be 10",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        password:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        confirm_password:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        }

    }

})