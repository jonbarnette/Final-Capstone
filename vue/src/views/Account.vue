<template>

  <div class="account">
    
    <h1>Welcome Back 'put cat/user name here'!</h1>
    <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src='../Assets/CatUsers/1015.jpg' />
  <add-cat></add-cat>
   
  </div>
  

</template>

<script>

import AddCat from '../components/AddCat.vue';



export default {
  name: "account",
  components: {
    AddCat
  },
};
</script>

<style scoped>
.water-cat {
  height: 50%;
  width: 50%;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.home {
  text-align: center;
}

#delete {
  font-size: .5em;

}

/* * {
  background-image: url("../Assets/CatUsers/1015.jpg");
  background-position: center center;
  background-size: cover;
  background-repeat: no-repeat;
  background-attachment: fixed;
} */
</style>