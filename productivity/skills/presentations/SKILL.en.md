---
name: presentations
description: Use when building a presentation of 8 to 12 slides with clear titles, concise points and speaker notes.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Building presentations

## When to use
- The user wants a presentation about a topic, a product, a report or an idea.
- They want to turn a text or document into slides.

## Workflow
1. Identify the topic, the audience, the goal (persuade, introduce, report) and the approximate duration. Ask one short question only if something essential is missing.
2. Sketch the structure of the deck within 8 to 12 slides: title, agenda or the main idea, the core sections, the conclusion, the next step or questions.
3. For each slide write: a title that expresses the idea (a short statement, not a bare word), 3 to 5 concise points (one line per point), and speaker notes (2–4 sentences explaining what to say).
4. Suggest a visual element for each slide where needed (chart, table, image) and describe it rather than inventing it.
5. If a file-creation tool is available (pptx or another), create the file; otherwise present the content as organized Markdown, slide by slide.
6. Review the logical flow, the balance of slide density and the consistency of terminology.

## Output format
When presenting the content as text, repeat this block for each slide:
```text
### Slide [number]: [Title]
- Point (3 to 5 points, one line each)
**Suggested visual:** [description, or "not needed"]
**Speaker notes:** [2–4 sentences]
```
Two lines precede the slides: the assumed audience and duration. It ends with a short list of what the user needs to complete.

## Full example
**Input:** "Prepare an 8-slide presentation on the importance of enough sleep for office workers, 10 minutes long."

**Expected output (the deck outline, then one slide in detail):**
```text
Audience: office employees. Duration: about 10 minutes.

1. Enough sleep is the basis of better performance
2. What we will cover today
3. What happens to the body during sleep
4. How lack of sleep affects concentration
5. Pre-sleep habits that help and that harm
6. A suitable sleep environment
7. A one-week plan to improve sleep
8. Conclusion: three habits to start tonight

### Slide 4: Lack of sleep weakens concentration at work
- Fatigue slows decision-making.
- Mistakes increase in repetitive tasks.
- [TBD: figures or a study from a reliable source, if you wish]
**Suggested visual:** a simple drawing comparing concentration on a well-slept day and a short-sleep day (no numbers unless provided).
**Speaker notes:** Start by asking the audience about their last workday after a short night.
Link their answers to the points, and stress that the goal is small habits that can be applied.
```
(Every real deck is written out in full with all its slides; the abbreviation above is for illustration.)

## Edge cases
- **A request for fewer than 8 or more than 12 slides:** apply the skill's constraint (8–12) and tell the user, or suggest merging the deck.
- **A very long source document:** focus on the main sections, and move the details to the speaker notes or a separate appendix.
- **The user did not specify the audience:** assume a general audience and mark the assumption at the top of the deck.
- **Conflicting figures in the source:** do not choose silently; include both figures on one slide marked [review] and tell the user.
- **A slide requested with statistics that are not available:** put [TBD] and suggest the suitable type of source without naming or inventing one.
- **The creation tool is unavailable or failed:** present the content as text in the format above and do not claim to have created a file.

## Rules and limits
- The number of slides is no fewer than 8 and no more than 12.
- Do not put long paragraphs on a slide; details go in the speaker notes.
- Do not invent figures, statistics, quotations or sources; use what the user provided or mark the spot [TBD].
- Follow the Arabic writing direction (right to left) when creating a file in Arabic.
- Make the last slide a conclusion or a call to action, not "Thank you" alone.
