# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you plan to deploy to.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding to deployment.

### 5. Verify Runtime Behavior

Run the application locally to confirm it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Test the core user-facing functionality manually, paying particular attention to areas that relied on Windows-specific APIs or libraries in the legacy project, as these are the most common sources of runtime issues that do not surface as build errors.

### 6. Check for Windows-Specific Dependencies

Even with a clean build, some APIs may compile successfully but throw `PlatformNotSupportedException` at runtime on non-Windows platforms. Review the codebase for usage of the following and test on the target platform:

- `Microsoft.Win32` registry access
- `System.Drawing` (GDI+)
- Windows Authentication or NTLM
- COM interop

### 7. Review Configuration Files

Ensure that `appsettings.json` (or equivalent) contains all configuration values that were previously held in `Web.config` or `App.config`. The transformation tooling may not migrate all configuration entries automatically. Cross-reference the original config files with the new configuration to confirm completeness.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.