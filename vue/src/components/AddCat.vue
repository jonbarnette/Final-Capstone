<template>
  <div>
    <h3>Please Enter Your Details</h3>
  <div class="container5">
    
    <form class="profile" @submit.prevent="submitForm">
      <label  for="fname">Name</label>
      <input  type="text" id="fname" name="name" v-model="cat.name" placeholder="Your name.." />

      <label  for="lives">Lives</label>
      <input  type="text" id="lives" name="lives" v-model="cat.lives" placeholder="How many lives left.."
        required/>

      <label  for="breed">Breed</label>
      <input  type="text" id="breed" name="breed"  v-model="cat.breed" placeholder="Your breed.." />

      <label  for="color">Color</label>
      <input
      
        type="text"
        id="color"
        name="color"
        v-model="cat.color"
        placeholder="Your color(s).."
        required
      />

      <label  for="occupation">Occupation</label>
      <input
      
        type="text"
        id="occupation"
        name="occupation"
        v-model="cat.occupation"
        placeholder="Your occupation.."
        required
      />

      <label  for="address">Address</label>
      <input
      
        type="text"
        id="address"
        name="address"
        v-model="cat.address"
        placeholder="Your address.."
        required
      />

      <label  for="tagline">Tagline</label>
      <textarea
      
        id="tagline"
        name="tagline"
        v-model="cat.tagline"
        placeholder="Write something.."
        style="height: 100px"
        required
      ></textarea>
      <label  for="summary">Summary</label>
      <textarea
      
        id="summary"
        name="summary"
        v-model="cat.summary"
        placeholder="Write something.."
        style="height: 100px"
        required
      ></textarea>
     <button  type="submit" class="catProfileButton" value="Create Profile">Free Mice</button>
    </form>
  </div>
  </div>
</template>


<script>
import catService from "../services/CatService";

export default {
  name: "add-cat",

  data() {
    return {
      // catNinja: false,
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
            // this.$router.push("/catdetails/" + this.$store.state.user.id);
            this.$router.push("/cats");
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

h3 {
  font-family: "Ledger", serif;
  font-size: 3rem; 
  text-align: center;
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
  outline: 0;
  
}
button[type="submit"]:hover {
  background-color: #f6faf6;
  color: #163da1;
}

button[type="submit"]:active {
            transform: scale(0.98);
            /* Scaling button to 0.98 to its original size */
            box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
            /* Lowering the shadow */
            
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