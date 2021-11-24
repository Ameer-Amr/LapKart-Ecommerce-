console.log('successs')


$("#register").validate({
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
        password1:{
            required:true,
            minlength:4,
            maxlength:10,
        },
        password2:{
            required:true,
            minlength:4,
            maxlength:10,
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
        password1:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        },
        password2:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        }

    }

})