const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin
admin.initializeApp();

const db = admin.firestore();

// User Authentication API
exports.login = functions.https.onRequest(async (req, res) => {
  // Enable CORS
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  try {
    const { email, password } = req.body;

    // Authenticate user
    const userRecord = await admin.auth().getUserByEmail(email);
    
    // Get user data from Firestore
    const userDoc = await db.collection('users').doc(userRecord.uid).get();
    const userData = userDoc.data();

    res.json({
      status: true,
      message: 'Login successful',
      data: {
        user: {
          id: userRecord.uid,
          email: userRecord.email,
          name: userData?.name || userRecord.email,
          ...userData
        },
        token: await admin.auth().createCustomToken(userRecord.uid)
      }
    });
  } catch (error) {
    res.status(400).json({
      status: false,
      message: error.message,
      data: null
    });
  }
});

exports.register = functions.https.onRequest(async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  try {
    const { email, password, name } = req.body;

    // Create user
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: name
    });

    // Save user data to Firestore
    await db.collection('users').doc(userRecord.uid).set({
      name: name,
      email: email,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      subscription: 'free',
      usage: {
        messages: 0,
        documents: 0,
        voiceClones: 0
      }
    });

    res.json({
      status: true,
      message: 'Registration successful',
      data: {
        user: {
          id: userRecord.uid,
          email: userRecord.email,
          name: name
        },
        token: await admin.auth().createCustomToken(userRecord.uid)
      }
    });
  } catch (error) {
    res.status(400).json({
      status: false,
      message: error.message,
      data: null
    });
  }
});

// Chat API
exports.sendMessage = functions.https.onRequest(async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  try {
    const { userId, message, modelType } = req.body;

    // Save chat to Firestore
    const chatRef = await db.collection('chats').add({
      userId: userId,
      message: message,
      modelType: modelType || 'gpt-4',
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      response: 'This is a mock response from Firebase Functions'
    });

    res.json({
      status: true,
      message: 'Message sent successfully',
      data: {
        chatId: chatRef.id,
        response: 'This is a mock response from Firebase Functions'
      }
    });
  } catch (error) {
    res.status(400).json({
      status: false,
      message: error.message,
      data: null
    });
  }
});

exports.getChatHistory = functions.https.onRequest(async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  try {
    const { userId, limit = 50 } = req.query;

    const chatsSnapshot = await db.collection('chats')
      .where('userId', '==', userId)
      .orderBy('timestamp', 'desc')
      .limit(parseInt(limit))
      .get();

    const chats = [];
    chatsSnapshot.forEach(doc => {
      chats.push({
        id: doc.id,
        ...doc.data()
      });
    });

    res.json({
      status: true,
      message: 'Chat history retrieved',
      data: chats
    });
  } catch (error) {
    res.status(400).json({
      status: false,
      message: error.message,
      data: null
    });
  }
});

// Admin API
exports.getAllUsers = functions.https.onRequest(async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  try {
    const usersSnapshot = await db.collection('users').get();
    const users = [];

    usersSnapshot.forEach(doc => {
      users.push({
        id: doc.id,
        ...doc.data()
      });
    });

    res.json({
      status: true,
      message: 'Users retrieved successfully',
      data: users
    });
  } catch (error) {
    res.status(400).json({
      status: false,
      message: error.message,
      data: null
    });
  }
});

