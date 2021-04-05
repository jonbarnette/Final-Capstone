<template>
  <div class="container">
      <div id="copycat">&#169; {{ copyText }}</div>
        <div id="contact">Contact</div>
        <div id="aboutUs">About Us</div>
        <div id="admin">Admin Login</div>
  </div>
</template>

<script>
export default {
  name: "the-footer",
  data() {
    return {
      copyText: "It's the cat's pajamas!",
    };
  },
};
</script>

<style>
.container {
    display: flex;
    float: center;
    text-align: center;
    padding: auto;
    justify-content: space-between;
    margin: 1em;

}

</style>