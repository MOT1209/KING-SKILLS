---
name: editing-style-coach
description: Use to learn, plan and apply a modern tech-YouTube editing style (consistent identity, big titles, picture-in-picture, screen-recording zooms, keyframe motion) in any video editor, through concepts rather than buttons.
---

<!-- English translation of SKILL.md (Arabic is the version Claude uses). Keep both in sync. -->

# Editing style coach

## When to use
- The user wants to learn video editing, or to copy the style of reference videos they liked.
- Building a weekly learning plan, a title template or an edit checklist for a specific video.
- Translating an effect they saw into the tools of CapCut, DaVinci Resolve, Premiere Pro or After Effects.

Do not use when: the request is to actually cut a timeline in Resolve (`davinci-resolve-video-edit`), a fully executed long-form edit (`davinci-resolve-pro-edit`), finished shorts (`create-video-shorts`), or a thumbnail (`create-youtube-thumbnails`); this skill teaches and plans.

## Workflow
1. Understand the goal, one question at a time: which editor, what kind of videos, which element of the reference style they liked, and how many hours a week.
2. Analyze the references: visual identity, shot variety, titles, motion, picture-in-picture, zooms and sound. Describe only what was observed, and say plainly what was not.
3. Break every effect down to what changes over time: size, position, opacity, speed or color, with its duration and easing.
4. Map each element to a concept in the concepts table below, then to its name in the user's editor.
5. Plan the learning path with the stages table below, adjusting the time to the user's schedule.
6. Apply it to the user's project: a title template, a shot order, a motion list or an edit checklist.
7. Review their result against the references and list at most three improvements, by priority.

### Concepts across editors
| Concept | CapCut | DaVinci Resolve | Premiere / After Effects |
|---|---|---|---|
| Timeline and tracks | Timeline | Edit page | Timeline |
| Keyframes | Keyframe | Inspector, then Keyframes | Effect Controls |
| Easing | Ease in/out | Curve Editor | Ease In/Out; Easy Ease in After Effects |
| Picture-in-picture | Overlay | Transform on an upper track | Scale on the upper track |
| Zoom on part of the screen | Scale + Position | Zoom + Position | Scale + Position |
| Title template | Text preset | Fusion Title | Essential Graphics |
| Mask | Mask | Power Window | Mask |
| Color | Filters / Adjust | Color page | Lumetri Color |
| Audio | Audio tools | Fairlight | Essential Sound |

### Learning stages (4 to 5 hours a week)
| Stage | Time | Exercise |
|---|---|---|
| 0. Preparation | 1-2 days | Pick an editor, collect 5 reference clips, create folders: footage, audio, graphics, exports |
| 1. Basics | Week 1 | 2-minute video: cut silences, order shots, set the audio level |
| 2. Titles and identity | Week 2 | One font and two colors, a main and a sub title in a full video |
| 3. Motion | Week 3 | Animate 3 icons with scale, fade and movement, with easing |
| 4. Composition | Week 4 | A before/after example with the presenter in a corner; zoom a screen recording |
| 5. Color and sound | Week 5 | Match colors across shots, remove noise, add low music under the voice |
| 6. Full project | Week 6 | A 5-7 minute video combining everything above |
| 7. Review and publish | After week 6 | Export at 1080p, compare with the references, write 3 improvements |

Repeat stages 6 and 7 with every new video.

## Output format
1. **Goal summary:** the editor, the video type and the elements to learn.
2. **Reference analysis:** a "video | what was observed" table, marking anything unseen as [not viewed].
3. **Effect breakdown:** what changes, duration, easing, concept and its name in the editor.
4. **Plan or application:** the adjusted stages table, or the title template (font, size, colors, position, motion), or the checklist.
5. **Next step:** one exercise that ends in a short clip the user keeps.

## Rules and limits
- Reply in the user's language, and keep menu and tool names in English as they appear in the editor.
- Do not assume a specific editor; give the concept first, then its names, and ask about the editor only when button-level steps are needed.
- Do not claim to have watched a video you have no frames of; if only a title or description is available, say so and ask for screenshots or a description.
- Still frames do not reveal pacing or sound; say so when analyzing from them.
- Menu names change between versions; ask the user to check them against their version.
- Do not suggest music, fonts or footage without a license, and flag rights.
- One exercise per stage, and no promises of views or engagement.

## Edge cases
- **A video link that does not open:** say you have not watched it, and ask for screenshots or a description of what they liked.
- **No editor chosen yet:** explain through concepts, and suggest a free editor to start with while leaving the choice to them.
- **Less than 4 hours a week:** stretch each stage to two weeks rather than dropping stages.
- **An editor not in the table:** use the concept, and ask them to look up the matching name in that editor's manual.
- **A request to do the edit for them:** explain that this skill teaches, and point to the right executing skill.
- **References with conflicting styles:** ask them to pick one main reference for the identity.

## Full example
**Input:** "I liked the screen zoom in [channel name]'s video. How do I do it in CapCut?"

**Expected output:**
```text
Goal: CapCut, a screen-recording tutorial, element: zooming in on the important text.
References: I have not watched the video [not viewed]; the breakdown is based on your description.

Breakdown:
| What changes | Duration | Easing | Concept | In CapCut |
|---|---|---|---|---|
| Size from 100% to a starting value such as 150% | [TBD: measure it in the reference] | Smooth in and out | Keyframes + easing | Keyframe on Scale and Position, then Ease in/out |
| Position toward the important text | Same duration | Same | Zoom on part of the screen | Position |

Steps: add a keyframe before the zoom, another once the new size is reached, and a third for the return.
Next step: zoom one part of a 30-second recording and keep it to compare later.
```
