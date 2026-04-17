import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';
import chatRouter from './routes/chat.js';
import adminRouter from './routes/admin.js';
import { initIndex, listDocuments, getDocument } from './services/rag.js';