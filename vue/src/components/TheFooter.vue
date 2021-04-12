<template>
<div id="footerposition">
  <div class="socialmedia">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <a href="#" class="fa fa-facebook"></a>
    <a href="#" class="fa fa-twitter"></a>
    <a href="#" class="fa fa-linkedin"></a>
    <a href="#" class="fa fa-youtube"></a>
    <a href="#" class="fa fa-instagram"></a>
    <a href="#" class="fa fa-snapchat-ghost"></a>
    <a href="#" class="fa fa-tumblr"></a>
    <a href="#" class="fa fa-vine"></a>
    <a href="#" class="fa fa-reddit"></a>
  </div>
  <div class="container1">
      <div id="copycat">&#169; {{ copyText }}</div>
        <div id="contact"><a href="#" style="text-decoration: none;">Contact</a></div>
        <div id="aboutUs"><a a href="#" style="text-decoration: none;">About Us</a></div>
        <div id="admin"><a href="#" style="text-decoration: none;">Admin Login</a></div>
  </div>
</div>
</template>

<script>
export default {
  name: "the-footer",
  data() {
    return {
      copyText: "Tabby Pro 2021",
    };
  },
};
</script>

<style>

.container1 {
    display: flex;
    text-align: center;
    padding: auto;
    justify-content: space-between;
    margin: 1em;
}
.socialmedia {
  display: flex;
  justify-content: space-around;
  margin-top: 10px;
}

.fa {
  padding: 20px;
  font-size: 60px;
  width: 50px;
  text-align: center;
  text-decoration: none;
  margin: 5px 2px;
}
.fa:hover {
    opacity: 0.7;
}





</style>