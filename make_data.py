import csv

# قائمة الإجابات السلبية والإيجابية
data = {
    "Negative": [
        "Mentally drained", "Exhausted", "Overwhelmed",
        "Always a struggle", "Too much effort", "Overwhelming",
        "Never rested", "Constantly tired", "Drained",
        "Heavy body", "Worn out", "Drained quickly",
        "No motivation", "Dreading it", "Low energy",
        "Lost drive", "Can’t keep up", "Lacking energy",
        "Easily fatigued", "No stamina", "Emotionally strained",
        "Burned out", "Unmotivated", "No passion", "Disengaged",
        "Detached", "Uncaring", "Apathetic", "Cynical",
        "Doesn’t matter", "Unimportant", "Distracted",
        "Unfocused", "Easily sidetracked", "Foggy mind",
        "Confused", "Unclear", "Forgetful", "Lose focus",
        "Easily distracted", "Frequent errors", "Not focused",
        "Emotional outbursts", "Irritable", "Unstable",
        "Not myself", "Changed", "Easily frustrated",
        "Quick-tempered", "Unexplained sadness", "Emotional", "Low mood"
    ],
    "Positive": [
        "Sometimes tired", "Manageable", "Not too bad",
        "Worth it", "Challenging but fine", "Mostly manageable",
        "Rechargeable", "Easily recovered", "Mostly rested",
        "Physically fine", "Manageable fatigue", "Occasionally tired",
        "Energized", "Ready to go", "Generally motivated",
        "Mostly engaged", "Driven", "Good stamina",
        "Generally strong", "Refreshed", "Energized",
        "Enthusiastic", "Motivated", "Passionate",
        "Invested", "Interested", "Connected",
        "Positive outlook", "Purposeful", "Meaningful",
        "Focused", "Attentive", "On task",
        "Clear-minded", "Alert", "Sharp",
        "Sharp memory", "Good focus", "Productive",
        "Few errors", "Emotionally stable", "Calm", "Balanced",
        "Self-aware", "Patient", "Flexible", "Adaptable",
        "Emotionally balanced", "Stable", "Positive"
    ]
}

# كتابة البيانات إلى ملف CSV
output_file = "answers_classification_dataset.csv"

with open(output_file, mode="w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    # كتابة العناوين
    writer.writerow(["Answer", "Label"])

    # كتابة الإجابات مع تصنيفاتها
    for label, answers in data.items():
        for answer in answers:
            writer.writerow([answer, label])

print(f"✅ Dataset saved to '{output_file}' successfully!")