# T3 LiveView - Distributed AI Chat

A high-performance AI chat application built with Phoenix LiveView for the T3 Chat Cloneathon.

## 🚀 Architecture

**Core Concept**: Leverage BEAM's distributed actor model to make chat blazing fast while keeping costs minimal.

- **Phoenix LiveView**: Real-time UI without JavaScript complexity
- **PostgreSQL**: Single database for cold storage
- **Actor Model**: Each chat is a stateful GenServer process
- **Memory-First**: Hot data in ETS, database is just backup
- **Global Distribution**: BEAM nodes can run anywhere, chats follow users

## ✅ T3 Cloneathon Goals

### Required Features
- [ ] Support multiple language models (OpenAI, Anthropic, etc.)
- [ ] User authentication with chat history sync

### Bonus Features
- [ ] File attachments (images, PDFs)
- [ ] AI image generation
- [ ] Code syntax highlighting
- [ ] Resumable conversation streams
- [ ] Chat branching
- [ ] Conversation sharing
- [ ] Web search integration

## 🎯 Technical Approach

### Why LiveView + Actors?
```
User → WebSocket → LiveView Process → Chat Actor (GenServer) → AI Provider
                                    ↓
                              PostgreSQL (async)
```

- Each chat session is an isolated actor
- Streaming responses flow naturally through WebSockets
- No API layer needed - direct server-to-client updates
- Fault tolerance built-in with supervisors

### Performance Goals
- Sub-100ms initial page load
- Instant message sending (optimistic UI)
- Zero-latency client interactions
- Streaming tokens as fast as AI provides them, from a locally sourced llm provider

## 📜 License

MIT

---

Built with Elixir for the T3 Chat Cloneathon 2025