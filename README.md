Friday AI: GLP-1 Companion (AI Engine demo)

A small native iOS demo of an emotional-support chat for adults whose relationship with food has changed while taking GLP-1 medication. The focus is the AI engine: a conversation that listens, asks one good question at a time, and helps the user find her own small way to adapt, instead of handing out generic advice.

Run it
Open FridayAI.xcodeproj in Xcode 26
Put a Gemini API key into AIService.swift (apiKey). A key from Google AI Studio works on the free tier.
Pick an iPhone simulator and press Run.

On first launch the app asks for a first name (stored locally), then opens the chat.

Model and API
Model: Google Gemini (gemini-flash-latest) via the generateContent REST endpoint.
No third-party SDKs: plain URLSession + async/await.
Fictional data only. Nothing is stored except the first name, locally on the device.
What is configured in the AI engine
System instruction (Prompt.swift), sent with every request and structured into sections:
Role and limits: a supportive companion, explicitly not a doctor or therapist.
Communication style: warm, natural English, 2-5 sentences, plain text, no lists, no stock openings such as "I understand" or "That sounds".
Emotional understanding: looks for what the old routine gave the user (anticipation, closure, reward, ritual), offers interpretations as possibilities and lets the user correct them.
Conversation flow: a three-stage arc. Early turns reflect and ask one open question about what Fridays used to give her. Middle turns explore what feels missing and let her name it. Only then does the AI ask what she wants to keep and offer one small idea tied to her own words, checking whether it feels right.
Safety: never suggests starting, stopping or changing medication or dose (redirects to the prescriber), no diagnosis, no claim that the drug caused the feeling, and a gentle pointer to a professional or crisis line if the user expresses hopelessness or self-harm.
Full conversation history is sent on every request (user / model roles), so the AI remembers details and does not repeat questions.
Personalization: the user's name is injected into the system instruction and used sparingly.
Generation settings: temperature 0.8 for natural variation, maxOutputTokens 1024.
Resilience: friendly error messages for rate limits (429) and overload (503), tolerant response decoding.
Why this beats a basic chatbot

A default chatbot answers "I feel empty on Fridays" with a bulleted list of tips. This engine:

Responds to the feeling first and asks exactly one open question.
Treats the loss as a lost ritual (anticipation, reward, closure), not as a food problem.
Lets the user name what is missing, then co-creates one specific idea from her own words instead of prescribing.
Keeps the user in control and holds firm medical boundaries.
Remembers earlier turns, so the conversation builds instead of resetting.
Limitations

Demo scope: no persistence of chat history, no accounts, no streaming. The API key is called from the client, which is fine for a demo; a production app should proxy requests through a backend.
