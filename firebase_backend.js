// Firebase Backend for Chatsy App
import { initializeApp } from 'firebase/app';
import { getFirestore, collection, doc, getDoc, setDoc, addDoc, query, where, getDocs, orderBy, limit } from 'firebase/firestore';
import { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword, signOut } from 'firebase/auth';

// Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "ai-chatsy-390411.firebaseapp.com",
  projectId: "ai-chatsy-390411",
  storageBucket: "ai-chatsy-390411.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef123456789"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app);

// API Endpoints
export const apiEndpoints = {
  // User Authentication
  async login(email, password) {
    try {
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      
      // Get user data from Firestore
      const userDoc = await getDoc(doc(db, 'users', user.uid));
      const userData = userDoc.data();
      
      return {
        status: true,
        message: 'Login successful',
        data: {
          user: {
            id: user.uid,
            email: user.email,
            name: userData?.name || user.email,
            ...userData
          },
          token: await user.getIdToken()
        }
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  async register(email, password, name) {
    try {
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;
      
      // Save user data to Firestore
      await setDoc(doc(db, 'users', user.uid), {
        name: name,
        email: email,
        createdAt: new Date(),
        subscription: 'free',
        usage: {
          messages: 0,
          documents: 0,
          voiceClones: 0
        }
      });
      
      return {
        status: true,
        message: 'Registration successful',
        data: {
          user: {
            id: user.uid,
            email: user.email,
            name: name
          },
          token: await user.getIdToken()
        }
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  // Chat Management
  async sendMessage(userId, message, modelType = 'gpt-4') {
    try {
      const chatData = {
        userId: userId,
        message: message,
        modelType: modelType,
        timestamp: new Date(),
        response: 'This is a mock response from Firebase backend'
      };
      
      const docRef = await addDoc(collection(db, 'chats'), chatData);
      
      return {
        status: true,
        message: 'Message sent successfully',
        data: {
          chatId: docRef.id,
          response: chatData.response
        }
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  async getChatHistory(userId, limitCount = 50) {
    try {
      const q = query(
        collection(db, 'chats'),
        where('userId', '==', userId),
        orderBy('timestamp', 'desc'),
        limit(limitCount)
      );
      
      const querySnapshot = await getDocs(q);
      const chats = [];
      
      querySnapshot.forEach((doc) => {
        chats.push({
          id: doc.id,
          ...doc.data()
        });
      });
      
      return {
        status: true,
        message: 'Chat history retrieved',
        data: chats
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  // User Management
  async getUserProfile(userId) {
    try {
      const userDoc = await getDoc(doc(db, 'users', userId));
      
      if (userDoc.exists()) {
        return {
          status: true,
          message: 'User profile retrieved',
          data: {
            id: userId,
            ...userDoc.data()
          }
        };
      } else {
        return {
          status: false,
          message: 'User not found',
          data: null
        };
      }
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  async updateUserProfile(userId, updateData) {
    try {
      await setDoc(doc(db, 'users', userId), updateData, { merge: true });
      
      return {
        status: true,
        message: 'Profile updated successfully',
        data: updateData
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  },

  // Admin Functions
  async getAllUsers() {
    try {
      const querySnapshot = await getDocs(collection(db, 'users'));
      const users = [];
      
      querySnapshot.forEach((doc) => {
        users.push({
          id: doc.id,
          ...doc.data()
        });
      });
      
      return {
        status: true,
        message: 'Users retrieved successfully',
        data: users
      };
    } catch (error) {
      return {
        status: false,
        message: error.message,
        data: null
      };
    }
  }
};

export default apiEndpoints;

