# Chat System Data Model Plan

## Overview
A chat system with branching and message regeneration capabilities. Messages are immutable and can be shared across different chat branches.

## Models

### Chat
Container for messages with branching support.

```typescript
interface Chat {
  id: string
  title: string
  createdAt: Date
  updatedAt: Date
  parentChatId?: string
}
```

### Message
Immutable message content. Never deleted, can be shared across chats.

```typescript
interface Message {
  id: number // snowflake again
  content: string
  role: 'user' | 'assistant'
  createdAt: Date
}
```

### ChatMessage
Join table linking chats to messages with ordering.

```typescript
interface ChatMessage {
  id: number // snowflake? auto ordering with inserting would be nice
  chatId: string
  messageId: string
}
```

## Operations

### Branching
When a user branches from a message:
1. Create new Chat with `parentChatId` set to the original chat
2. Create new ChatMessage entries for the new chat, pointing to the same Message records up to the branch point
3. New messages after the branch point get their own Message and ChatMessage entries

### Message Regeneration
When a user regenerates a message:
1. Delete all ChatMessage entries from that position onward in the current chat
2. Create a new Message with the regenerated content
3. Create a new ChatMessage entry linking the new message to the chat

## Key Design Decisions
- Messages are immutable and never deleted
- Multiple chats can reference the same messages (efficient for branching)
- ChatMessage join table handles ordering and chat-specific message lists
- No soft deletes needed - just remove ChatMessage entries for regeneration