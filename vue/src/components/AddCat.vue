<template>
  
  <div class="container5">
    <button class="ninjaButton" v-on:click="catNinja = !catNinja"><h3>Edit Cat</h3></button>
    <form class="profile" @submit.prevent="submitForm">
      <label v-show="catNinja" for="fname">Name</label>
      <input v-show="catNinja" type="text" id="fname" name="name" v-model="cat.name" placeholder="Your name.." />

      <label v-show="catNinja" for="lives">Lives</label>
      <input v-show="catNinja" type="text" id="lives" name="lives" v-model="cat.lives" placeholder="How many lives left.."
        required/>

      <label v-show="catNinja" for="breed">Breed</label>
      <input v-show="catNinja" type="text" id="breed" name="breed"  v-model="cat.breed" placeholder="Your breed.." />

      <label v-show="catNinja" for="color">Color</label>
      <input
      v-show="catNinja"
        type="text"
        id="color"
        name="color"
        v-model="cat.color"
        placeholder="Your color(s).."
        required
      />

      <label v-show="catNinja" for="occupation">Occupation</label>
      <input
      v-show="catNinja"
        type="text"
        id="occupation"
        name="occupation"
        v-model="cat.occupation"
        placeholder="Your occupation.."
        required
      />

      <label v-show="catNinja" for="address">Address</label>
      <input
      v-show="catNinja"
        type="text"
        id="address"
        name="address"
        v-model="cat.address"
        placeholder="Your address.."
        required
      />

      <label v-show="catNinja" for="tagline">Tagline</label>
      <textarea
      v-show="catNinja"
        id="tagline"
        name="tagline"
        v-model="cat.tagline"
        placeholder="Write something.."
        style="height: 100px"
        required
      ></textarea>
      <label v-show="catNinja" for="summary">Summary</label>
      <textarea
      v-show="catNinja"
        id="summary"
        name="summary"
        v-model="cat.summary"
        placeholder="Write something.."
        style="height: 100px"
        required
      ></textarea>
     <button v-show="catNinja" type="submit" class="catProfileButton" value="Create Profile">Free Mice</button>
    </form>
  </div>
</template>


<script>
import catService from "../services/CatService";

export default {
  name: "add-cat",

  data() {
    return {
      catNinja: false,
      cat: {
        name: '',
        imageName: '1015.jpg',
        breed: '',
        lives: '',
        color: '',
        occupation: '',
        tagline: '',
        address: '',
        summary: '',
      },
    };
  },
  methods: {
    submitForm() {
      catService
        .addCat(this.cat)
        .then((response) => {
          console.log(response.status);
          if (response.status == "201") {
            //success
            this.$router.push("/account");
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error);
        });
  },
  },
};
</script>

<style scoped>
* {
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

input[type="text"], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

::placeholder {
  color: black;
}
button[type="submit"] {
  background-color: #163da1;
  color: white;
  padding: 12px 20px;
  border: 2px solid #163da1;
  border-radius: 2em;
  cursor: pointer;
  width: 8em;
  align-items: center;
  
}
button[type="submit"]:hover {
  background-color: #f6faf6;
  color: #163da1;
}
.container5, form{
  border-radius: 5px;
  color: #163DA1;
  padding: 20px;
  font-family: monospace;
  width: 25em;
  margin: 0 auto;
  align-items: center;
}

.ninjaButton {

  border-radius: 3em;
  border: 3px solid  #163DA1 ; 
  background: transparent;
  outline: 0;
 
}
.ninjaButton:active {
            transform: scale(0.98);
            /* Scaling button to 0.98 to its original size */
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
            /* Lowering the shadow */
            
        }
</style>