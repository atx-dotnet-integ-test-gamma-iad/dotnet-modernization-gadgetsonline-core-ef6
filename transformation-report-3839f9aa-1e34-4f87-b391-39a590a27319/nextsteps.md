# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or target framework compatibility, as they may indicate areas that need further attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to confirm behavior is consistent with the original legacy project.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to reflect the new platform's behavior.

### 6. Check for Windows-Specific API Usage

Since this was a legacy project migration, scan the codebase for any remaining Windows-specific APIs that may not be cross-platform compatible. Common areas to check include:

- **Registry access** (`Microsoft.Win32.Registry`)
- **Windows file path assumptions** (e.g., hardcoded backslashes)
- **Windows-only authentication** (e.g., NTLM, Windows Identity)
- **System.Drawing** (GDI+ based) — replace with a cross-platform alternative such as `SkiaSharp` or `ImageSharp` if used

Use the .NET Compatibility Analyzer to assist with this:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

### 7. Review Configuration and Middleware

If this is an ASP.NET Core web project, review `Program.cs` and any `Startup.cs` to ensure:

- Middleware is registered in the correct order
- Connection strings and app settings have been migrated from `Web.config` to `appsettings.json`
- Any `Web.config` transforms or `system.web` configuration sections have been properly replaced with their ASP.NET Core equivalents

### 8. Verify Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder and that static file middleware is enabled in the application pipeline.

### 9. Database and Entity Framework Validation

If the project uses Entity Framework, verify the following:

- Migrations are present and up to date
- The connection string in `appsettings.json` is correct for the target environment
- Apply migrations against a local database to confirm schema integrity:

```bash
dotnet ef database update
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and self-contained:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.