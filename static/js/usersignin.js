$("#userlogin").validate({
    rules:{
        email:{
            required:true,
            email:true,

        },
        password:{
            required:true,
            minlength:4,
            maxlength:10,
        },
    },
    messages:{
        email:{
            email:"Please Enter Valid Email Address",
        },
        password:{
            minlength:"The Minimum Number of Characters should be 4",
            maxlength:"The Maximum Number of Characters should be 10",
        }
    }

})  