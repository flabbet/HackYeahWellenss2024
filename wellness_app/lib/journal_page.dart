import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {

final List<JournalEntry> entries = [];

JournalPage(){
  entries.add(JournalEntry("What made you feel the most positive today, and how did it impact your mood?", "Talking to a friend made me laugh, which helped me shake off the anxiety I was feeling earlier. I went for a walk in the park, and the fresh air really lifted my spirits. I felt more energized and less stressed afterward."));
  entries.add(JournalEntry("Is there something that’s been on your mind lately? How do you feel about it right now?", "I’ve been thinking a lot about my work deadlines. It’s overwhelming, but after breaking things down into smaller tasks, I feel more in control. I’ve been feeling distant from a friend. I’m unsure how to approach the situation, but journaling is helping me sort through my emotions. I’m worried about an upcoming event, but practicing mindfulness today helped me feel a bit calmer about it."));
  entries.add(JournalEntry("What’s one thing you did today that brought you closer to your goal?", "I took a break from my screen to meditate, which helped me clear my head and stay on track with my mental health goal."));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton.small(onPressed: () => {}, child: Icon(Icons.add),),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("Journal", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List<Widget>.generate(entries.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surfaceContainerHigh
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(entries[index].question, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14, fontWeight: FontWeight.w400),),
                            SizedBox(height: 12),
                            Text(entries[index].answer)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ));
  }
}

class JournalEntry{
  String question;
  String answer;

  JournalEntry(this.question, this.answer);
}