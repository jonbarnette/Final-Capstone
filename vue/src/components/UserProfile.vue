<template>
  <div>
    <h1>Welcome Back nya!</h1>
    <p>Under Catstruction. Please excuse the meows</p>
    <img class="water-cat" src="../Assets/CatUsers/1015.jpg" />
    <add-cat></add-cat>

    <form action="/action_page.php">
      <input type="file" id="myFile" name="filename" />
      <input type="submit" value="UPLOAD PICTURE" />
    </form>
  </div>
</template>

<script>
import AddCat from "../components/AddCat.vue";
export default {
  name: "user-profile",

  components: {
    AddCat,
  },
};
</script>

<style>
input[type="submit"] {
  width: 15em;
  font-weight: bold;
  color: white;
  background-color: tomato;
}

#myFile {
  width: 15em;
  font-weight: bold;
  color: white;
  background-color: tomato;
}

</style>