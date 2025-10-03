const functions = require('firebase-functions');
const admin = require('firebase-admin');

// Initialize Firebase Admin
admin.initializeApp();

const db = admin.firestore();

// Enable CORS for all functions
const cors = require('cors')({origin: true});

// User Authentication API
exports.login = functions.https.onRequest((req, res) => {
  return cors(req, res, async () => {
    try {
      const { email, password } = req.body;

      // For now, we'll create a mock response
      // In production, you'd authenticate with Firebase Auth
      res.json({
        status: true,
        message: 'Login successful',
        data: {
          user: {
            id: 'mock_user_id',
            email: email,
            name: email.split('@')[0]
          },
          token: 'mock_token_123'
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
});

exports.register = functions.https.onRequest((req, res) => {
  return cors(req, res, async () => {
    try {
      const { email, password, name } = req.body;

      // Mock registration
      res.json({
        status: true,
        message: 'Registration successful',
        data: {
          user: {
            id: 'mock_user_' + Date.now(),
            email: email,
            name: name
          },
          token: 'mock_token_' + Date.now()
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
});

// Chat API
exports.sendMessage = functions.https.onRequest((req, res) => {
  return cors(req, res, async () => {
    try {
      const { userId, message, modelType } = req.body;

      // Mock AI response
      const responses = [
        "Hello! I'm your AI assistant powered by Firebase!",
        "That's an interesting question. Let me help you with that.",
        "I understand what you're asking. Here's my response:",
        "Great question! Here's what I think:",
        "I'm here to help! Let me provide you with some information."
      ];

      const randomResponse = responses[Math.floor(Math.random() * responses.length)];

      res.json({
        status: true,
        message: 'Message sent successfully',
        data: {
          chatId: 'chat_' + Date.now(),
          response: randomResponse + " " + message
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
});

exports.getChatHistory = functions.https.onRequest((req, res) => {
  return cors(req, res, async () => {
    try {
      const { userId } = req.query;

      // Mock chat history
      const mockChats = [
        {
          id: 'chat_1',
          message: 'Hello!',
          response: 'Hi there! How can I help you today?',
          timestamp: new Date().toISOString()
        },
        {
          id: 'chat_2',
          message: 'What can you do?',
          response: 'I can help you with various tasks using AI!',
          timestamp: new Date().toISOString()
        }
      ];

      res.json({
        status: true,
        message: 'Chat history retrieved',
        data: mockChats
      });
    } catch (error) {
      res.status(400).json({
        status: false,
        message: error.message,
        data: null
      });
    }
  });
});

// Admin API
exports.getAllUsers = functions.https.onRequest((req, res) => {
  return cors(req, res, async () => {
    try {
      // Mock users data
      const mockUsers = [
        {
          id: 'user_1',
          name: 'John Doe',
          email: 'john@example.com',
          subscription: 'premium',
          createdAt: new Date().toISOString()
        },
        {
          id: 'user_2',
          name: 'Jane Smith',
          email: 'jane@example.com',
          subscription: 'free',
          createdAt: new Date().toISOString()
        }
      ];

      res.json({
        status: true,
        message: 'Users retrieved successfully',
        data: mockUsers
      });
    } catch (error) {
      res.status(400).json({
        status: false,
        message: error.message,
        data: null
      });
    }
  });
});

// Health check
exports.health = functions.https.onRequest((req, res) => {
  return cors(req, res, () => {
    res.json({
      status: true,
      message: 'Firebase Backend is running!',
      data: {
        server: 'Firebase Functions',
        timestamp: new Date().toISOString(),
        version: '1.0.0'
      }
    });
  });
});

